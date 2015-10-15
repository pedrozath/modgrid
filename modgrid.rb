MMS_IN_A_POINT = 2.8346500006281

def ask(message)
    puts message
    user_input = gets
    if user_input == "\n"
        ask(message)
    else 
        user_input
    end
end

def ask_float(message)
    ask(message).to_f
end

def ask_int(message)
    ask(message).to_i
end

def mm_to_pt(x)
    x*MMS_IN_A_POINT
end

def pt_to_mm(x)
    x/MMS_IN_A_POINT
end

canvas_width = ask_float("largura do papel (em mm)")
columns = ask_int("quantidade de colunas")
baseline = pt_to_mm ask_float("altura do baseline (em pt)")
puts("Isto equivale à #{baseline}mm")

maximum_units = (canvas_width/baseline).to_i
margin_correction = baseline*((canvas_width / baseline) - maximum_units) 

puts("cabem #{maximum_units} unidades dentro do papel. a correção de margem é #{margin_correction}mm.")

margin_units = ask_int("quantidade de unidades da margem (será acrescida da correção, para manter a proporção)")
puts("sua margem inicialmente fica de #{margin_units*baseline}mm")

units_in_usable_space = maximum_units-(margin_units*2)

puts("cabem #{units_in_usable_space} unidades dentro da área utilizável do papel")

(1...units_in_usable_space).each do |gutter_units|
    total_gutter_units = gutter_units * (columns - 1)
    column_units = (units_in_usable_space - total_gutter_units)/columns
    column = column_units*baseline
    gutter = gutter_units*baseline
    both_margins = canvas_width - ((column*columns) + (gutter*(columns-1)))
    margin = both_margins/2
    unless (column_units < 0 || gutter >= column)
        puts "coluna: #{column_units}x ou #{column}mm / gutter: #{gutter_units}x ou #{gutter}mm / margem: #{margin}mm"
    end
end