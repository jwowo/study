require_relative 'caffeine_beverage_with_hook'

class CoffeeWithHook < CaffeineBeverageWithHook
  def brew
    puts '필터로 커피를 우려내는 중'
  end

  def add_condiments
    puts '설탕과 우유를 추가하는 중'
  end

  def customer_wants_condiments
    user_input
  end

  def user_input
    answer = false
    puts '커피에 우유와 설탕을 넣을까요? (y/n)? '

    input_string = gets.chomp
    answer = true if input_string.to_s[0] == 'y'
    answer
  end
end
