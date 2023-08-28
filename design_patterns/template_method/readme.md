# 템플릿 메소드 패턴

> 템플릿 메소드 패턴은 알고리즘의 골격을 정의한다. 템플릿 메소드를 사용하면 알고리즘의 일부 단계를 서브클래스에서 구현할 수 있으며, 알고리즘의 구조는 그대로 유지하면서 알고리즘의 특정 단계를 서브클래스에서 재정의할 수도 있다

- 템플릿 메소드 패턴은 알고리즘의 틀을 만든다
- 여러 단계 가운데 하나 이상의 단계가 추상 메소드로 정의되며, 그 추상 메소드는 서브클래스에서 구현된다. 이를 통해 서브클래스가 일부분의 구현을 처리하게 하면서도 알고리즘의 구조를 변경하지 않아도 된다

## 시나리오

### 커피와 홍차 만들기

- 커피와 홍차에는 카페인이 있고, 비슷한 방법으로 만든다는 공통점이 있다
- 커피와 홍차 클래스를 만들어보자
```ruby
class Coffee
  def prepare_recipe
    boil_water
    brew_coffee_grinds
    pour_in_cup
    add_sugar_and_milk
  end

  def boil_water
    puts '물 끓이는 중'
  end

  def brew_coffee_grinds
    puts '필터로 커피를 우려내는 중'
  end

  def pour_in_cup
    puts '컵에 따르는 중'
  end

  def add_sugar_and_milk
    puts '설탕과 우유를 추가하는 중'
  end
end
```
```ruby
class Tea
  def prepare_recipe
    boil_water
    steep_tea_bag
    pour_in_cup
    add_remon
  end

  def boil_water
    puts '물 끓이는 중'
  end

  def steep_tea_bag
    puts '찻잎을 우려내는 중'
  end

  def pour_in_cup
    puts '컵에 따르는 중'
  end

  def add_remon
    puts '레몬을 추가하는 중'
  end
end
```
- Coffee와 Tea 클래스에 중복된 부분이 많다. 두 클래스에서 중복된 부분을 없앨 수 있는 디자인을 고민해보자

## 템플릿 메소드 구현

### Coffee 클래스와 Tea 클래스 추상화하기

- 커피와 홍차 제조법의 알고리즘이 똑같다는 것을 알 수 있다
  1. 물을 끓인다
  2. 뜨거운 물을 사용해서 커피 또는 찻잎을 우려낸다
  3. 만들어진 음료를 컵에 따른다
  4. 각 음료에 맞는 첨가물을 추가한다


### `#prepare_recipe` 메소드 추상화하기

```ruby
class CaffeineBeverage
  def prepare_recipe
    boil_water
    brew
    pour_in_cup
    add_condiments
  end

  def boil_water
    puts '물 끓이는 중'
  end

  def pour_in_cup
    puts '컵에 따르는 중'
  end

  def brew
    raise NotImplementedError
  end

  def add_condiments
    raise NotImplementedError
  end
end
```
```ruby
class Coffee < CaffeineBeverage
  def brew
    puts '필터로 커피를 우려내는 중'
  end

  def add_condiments
    puts '설탕과 우유를 추가하는 중'
  end
end
```
```ruby
class Tea < CaffeineBeverage
  def brew
    puts '찻잎을 우려내는 중'
  end

  def add_condiments
    puts '레몬을 추가하는 중'
  end
end
```

- `CaffeineBeverage` 클래스에 __템플릿 메소드__ 가 들어가있다
  - `#prepare_recipe` 이 템플릿 메소드
- 템플릿 메소드는 알고리즘을 관장한다. 알고리즘을 수행하는 과정에서 상황에 따라 특정 단계를 서브클래스에서 처리하도록 하는 경우도 있다

## 템플릿 메소드 패턴의 장점

- `CaffeineBeverage` 클래스에서 작업을 처리한다(알고리즘 독점)
- `CaffeineBeverage`를 이용하기 때문에 서브클래스에서 코드를 재사용할 수 있다
- 알고리즘이 한 군데에 모여 있으므로 한 부분만 고치면 된다
- 다른 음료도 쉽게 추가할 수 있는 프레임워크를 제공한다. 음료 추가시 몇 가지 메소드만 더 만들면 된다
- `CaffeineBeverage` 클래스에 알고리즘 지식이 집중되어 있으며 일부 구현만 서브클래스에 의존한다

## 템플릿 메소드 속 훅

- 훅(hook)은 추상 클래스에서 선언되지만 기본적인 내용만 구현되어 있거나 아무 코드도 들어 있지 않은 메소드이다
- 훅은 알고리즘에서 필수적이지 않은 부분을 서브클래스에서 구현하도록 만들고 싶을 때 사용할 수 있다
- 앞으로 일어날 일이거나 막 일어난 일에 서브클래스가 반응할 수 있도록 기회를 제공하는 용도로도 사용할 수 있다
  - 예) 내부적으로 특정 목록을 재정렬할 후에 서브 클래스에서 특정 작업(화면상에 표시되는 내용을 다시 보여주는 등)을 수행하고 싶을 때
- 훅을 이용하여 서브클래스가 추상 클래스에서 진행되는 작업을 처리할지 말지 결정하게 하는 기능 부여할 수 있다

```ruby
class CaffeineBeverageWithHook
  def prepare_recipe
    boil_water
    brew
    pour_in_cup
    if customer_wants_condiments
      add_condiments
    end
  end

  def customer_wants_condiments
    true
  end
end
```
```ruby
require_relative 'caffeine_beverage_with_hook'

class CoffeeWithHook < CaffeineBeverageWithHook
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
```
```ruby
require_relative 'coffee_with_hook'

coffee_hook = CoffeeWithHook.new
puts "커피 준비 중..."
coffee_hook.prepare_recipe
```

#### 템플릿 메소드 패턴 주의사항

- 추상 메소드가 너무 많아지면 서브클래스에서 일일이 추상 메소드를 구현해야하기 때문에 템플릿 메소드를 만들때 잘 생각해봐야 한다
- 알고리즘의 단계를 너무 잘게 쪼개지 않는 것도 하나의 방법이지만 유연성이 떨어질 수 있기 때문에 상황에 맞게 잘 고려해야 한다

### 할리우드 원칙

> 먼저 연락하지 마세요. 저희가 연락드리겠습니다

- 할리우드 원칙을 활용하면 의존성 부패를 방지할 수 있다
  - 의존성 부패란 의존성이 복잡하게 꼬여있는 상황을 의미한다
  - 의존성이 부패하면 시스템 디자인이 어떤 식으로 되어 있는지 아무도 알아볼 수 없다
- 할리우드 원칙을 사용하면 저수준 구성 요소가 시스템에 접속할 수는 있지만 언제, 어떠헥 그 구성 요소를 사용할지는 고수준 구성 요소가 결정한다
- 템플릿 메소드 패턴을 사용하면 서브 클래스에게 "우리가 연락할 테니까 먼저 연락하지마" 라고 이야기하는 것과 같다
  - `CaffeineBeverage`는 고수준 구성 요소로 음료를 만드는 방법에 해당하는 알고리즘을 장악하고 있고, 메소드 구현이 필요한 상황에만 서브클래스를 호출한다
  - 클라이언트는 구상 클래스(`Tea`, `Coffee`)가 아닌 슈퍼클래스(`CaffeineBeverage`)의 추상화되어 있는 부분에 의존한다. 따라서 전체 시스템의 의존성을 줄일 수 있다
  - 서브 클래스(`Tea`, `Coffee`)는 자질구레한 메소드 구현을 제공하는 용도로만 사용된다
  - 서브 클래스는 호출되기 전까지 추상 클래스를 직접 호출하지 않는다