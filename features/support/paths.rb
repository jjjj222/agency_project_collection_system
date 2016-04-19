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

    when /^login page/
      login_path

    when /^mypage$/
      mypage_path

    #when /^google authentication page$/
    #  "/auth/google_oauth2"

      #"https://accounts.google.com/ServiceLogin"
    #when /^the edit page for "([^"]*)"$/
    #  edit_movie_path(Movie.find_by_title($1))

    #when /^the details page for "([^"]*)"$/
    #  movie_path(Movie.find_by_title($1))

    #when /^the Similar Movies page for "([^"]*)"$/
    #  similar_movie_path(Movie.find_by_title($1))
      #test = edit_movie_path(Movie.find_by_title($1))
      #movies = Movie.where(title: $1)
      ##test = edit_movie_path(movies[0])
      #debugger
      #edit_movie_path(movies[0])
#When /^(?:|I )go to (.+) for "([^"]*)"$/ do |page_name, movie|

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

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
end

World(NavigationHelpers)
