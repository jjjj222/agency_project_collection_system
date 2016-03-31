module NameHelpers
  def underscore_words(words)
    words.gsub(/\s+/, '_').downcase
  end
end
World(NameHelpers)
