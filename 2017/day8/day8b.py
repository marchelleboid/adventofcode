registers = {}
max_value = -1000

with open('input') as f:
    for line in f:
        split_line = line.strip().split(' ')
        register = split_line[0]
        command = split_line[1]
        amount = int(split_line[2])
        conditional_register = split_line[4]
        condition = split_line[5]
        conditional_amount = int(split_line[6])

        conditional_register_value = registers[conditional_register] if conditional_register in registers else 0
        condition_met = False
        if condition == '>':
            condition_met = conditional_register_value > conditional_amount
        elif condition == '<':
            condition_met = conditional_register_value < conditional_amount
        elif condition == '>=':
            condition_met = conditional_register_value >= conditional_amount
        elif condition == '<=':
            condition_met = conditional_register_value <= conditional_amount
        elif condition == '==':
            condition_met = conditional_register_value == conditional_amount
        elif condition == '!=':
            condition_met = conditional_register_value != conditional_amount
        else:
            print('woops')

        if condition_met:
            register_value = registers[register] if register in registers else 0
            if command == 'inc':
                register_value += amount
            else:
                register_value -= amount
            registers[register] = register_value
            if register_value > max_value:
                max_value = register_value

print(max_value)
