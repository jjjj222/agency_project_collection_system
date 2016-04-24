class PresenterBase
  include ActionView::Helpers
  include Rails.application.routes.url_helpers

  # Replaces @foo.each do..end in views as Presenter.all(@foo) do..end
  def self.all(objs, &block)
    objs.map{|obj| self.new(obj) }.each(&block) unless objs.nil?
  end

  #TODO: wtf rails
  def protect_against_forgery?
    false
  end

end

class Class
  def present_obj(name)
    attr_accessor name
    self.class_eval("def initialize(#{name}); @#{name} = #{name}; end")
  end
end
