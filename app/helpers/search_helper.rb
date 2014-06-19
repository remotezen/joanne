def class_type(search)
  tmp = search.inspect.split(' ').to_a
  str = tmp[0].to_s.gsub(/[^0-9a-z ]/i, '').to_s
end
