module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  #def id_of(object_name)
  #  case object_name
  #  when /^Sign in with Google$/
  #    "google_login"
  #  else
  #    raise "Can't find mapping from \"#{object_name}\" to a id.\n" +
  #      "Now, go and add a mapping in #{__FILE__}"
  #  end
  #end

  def path_to(page_name)
    case page_name
    when /^home\s?page/
      root_path

    when /^(\w+) (.+) page$/i
      eval (controller_action_name action: $1, controller: $2)

    when /^(\w+) (.+) page for (?:the) (.*)$/i
      controller_action_path action: $1, controller: $2, param: $3

    else
      return nil
      #begin
      #  page_name =~ /^the (.*) page$/
      #  path_components = $1.split(/\s+/)
      #  self.send(path_components.push('path').join('_').to_sym)
      #rescue NoMethodError, ArgumentError
      #  raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      #    "Now, go and add a mapping in #{__FILE__}"
      #end
    end
  end

  def controller_action_name(opts)
    controller_name = underscore_words opts[:controller]

    # compute the url helper method name, e.g. edit_tamu_user
    path =
      if not ["index","show"].include? opts[:action]
        "#{opts[:action]}_#{controller_name}".downcase
      else
        controller_name
      end

    "#{path}_url"
  end

  def controller_action_path(opts)
    path_name = controller_action_name opts
    param_name = underscore_words opts[:param]
    code = "#{path_name} #{param_name}"
    eval code
  end
end

World(NavigationHelpers)
