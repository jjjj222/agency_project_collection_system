module TableHelpers
  # Given a table id, it grabs the header titles and uses them to
  # create an array of hashes with the names as keys in snake_case
  def table_from(id)
    header = page.first("##{id} tr").all("th").map do |th|
      underscore_words th.text
    end

    page.all("##{id} tr").drop(1).map do |tr|
      Hash[header.zip tr.all("td").map(&:text)]
    end
  end

  def sorted_by(key, table)
    puts table.map{|e| e[key] }.inspect
    table.map{|e| e[key]}.each_cons(2).all? { |a, b| (a <=> b) <= 0 }
  end

end

World(TableHelpers)
