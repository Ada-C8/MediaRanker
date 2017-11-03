module ApplicationHelper
def date_format(input_date)
  date = "#{input_date}"[0..10]
  return date
end

def nil_rescue(input)
  if input == nil
    return " "
  else
    return input
  end
end
end
