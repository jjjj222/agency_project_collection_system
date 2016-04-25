class PresenterBase
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  # Replaces @foo.each do..end in views as Presenter.all(@foo) do..end
  def self.all(objs, &block)
    objs.map{|obj| self.new(obj) }.each(&block) unless objs.nil?
  end
end

class Class
  def present_obj(name)
    attr_accessor name
    self.class_eval("def initialize(#{name}); @#{name} = #{name}; end")
    self.class_eval("def object; #{name}; end")
  end

  def present_with(method, *args)
    args.each do |attr|
      self.class_eval("def #{attr}; object.#{attr}.#{method}; end")
    end
  end
end
