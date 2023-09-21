require 'date'

array = ["texte 164 texte\nDu 25/09/2023 au 01/10/2023\nL 25 11:00-14:30 CAISS 15:30-19:30 ZSCA\nPauses: 12mn\nM 26 14:00-21:00 ROLL\nPauses: 21mn\nM 27 Repos\nJ 28 10:30-15:00 CAISS\nPauses: 12mn\nV 29 09:30-14:15 ROLL\nPauses: 12mn\nS 30 13:00-16:00 ROLL\nPauses: 18mn\nD 01 Fermé\n16:00-19:30 CCEN\n30:00\n30:15\n07:30\n07:00\n00:00\n04:30\n04:45\n06:30\n00:00", "texte", "164", "texte", "Du", "25/09/2023", "au", "01/10/2023", "L", "25", "11", ":", "00-14", ":", "30", "CAISS", "15", ":", "30-19", ":", "30", "ZSCA", "Pauses", ":", "12mn", "M", "26", "14", ":", "00-21", ":", "00", "ROLL", "Pauses", ":", "21mn", "M", "27", "Repos", "J", "28", "10", ":", "30-15", ":", "00", "CAISS", "Pauses", ":", "12mn", "V", "29", "09", ":", "30-14", ":", "15", "ROLL", "Pauses", ":", "12mn", "S", "30", "13", ":", "00-16", ":", "00", "ROLL", "Pauses", ":", "18mn", "D", "01", "Fermé", "16", ":", "00-19", ":", "30", "CCEN", "30:00", "30:15", "07:30", "07:00", "00:00", "04:30", "04:45", "06:30", "00:00"]
new_array = array[0].split(" ")
start_date = Date.parse(new_array[4])
end_date = Date.parse(new_array[6])
dates = []
days = []
(start_date..end_date).each do |date|
  dates << date
  days << date.day
end

new_array = array[0].split("\n").map(&:split)
hours = []

new_array.each do |line|
  line.each do |element|
    if element.match?(/\d{2}\/\d{2}\/\d{4}/)
    elsif element.match?(/\d{2}:\d{2}-\d{2}:\d{2}/)
      hours << element
    elsif element == 'Repos' || element == 'Fermé'
      hours << element
    elsif element.match?(/\d{2}/) && !element.match?(/\d{2}:/)
      hours << element
    end
  end
end

hours = hours.reject { |element| element.match?(/\d{2}mn\z/) || element.match?(/\d{3}\z/) }

start_hours = []
end_hours = []

days.each_with_index do |day, index|
  formatted_day = day.to_i < 10 ? "0#{day}" : day.to_s
  if index < days.length
    if /^[a-zA-Z]+$/.match?(hours[hours.index(formatted_day) + 1])
      start_hours << 'Repos'
    else
      start_hours << hours[hours.index(formatted_day.to_s) + 1].split('-')[0]
    end
  end
end

days.drop(1).each_with_index do |day, index|
  formatted_day = day < 10 ? "0#{day}" : day.to_s
  if index < days.length
    if /^[a-zA-Z]+$/.match?(hours[hours.index(formatted_day) - 1])
      end_hours << 'Repos'
    else
      end_hours << hours[hours.index(formatted_day.to_s) - 1].split('-')[1]
    end
  end
end
end_hours << 'Repos'

values = {
  date: dates,
  start_hour: start_hours,
  end_hour: end_hours
}
