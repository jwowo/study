# 팩토리 패턴

## 시작하기에 앞서

### `new` 연산자

- `new`를 사용하면 인터페이스가 아닌 특정 구현을 사용하는 구상 클래스의 인스턴스가 생긴다
- 이런 구상 클래스를 바탕으로 코딩하면 코드의 유연성이 떨어지고, 수정해야할 가능성이 높아진다

```java
Duck duck;
if (picnic) {
  duck = new MallardDuck();
} else if (hunting) {
  duck = new DecoyDuck();
} else if (inBathTub) {
  duck = new RubberDuck();
}
```

### 위 코드의 문제점

- 위 코드를 보면 구상 클래스의 인스턴스가 여러개 있고, 그 인스턴스의 형식은 실행에 결정된다
- 또한 이런 코드는 변경, 확장시 기존 코드를 확인해 수정해야해서 유지보수에 어려워질 수 있다
- 바뀌는 부분을 찾아내서 바뀌지 않는 부분과 분리하고 캡슐화해보자

## 시나리오 개요

- 최첨단 피자 코드 만들기

#### 기존 코드

```ruby
# main.rb
def order_pizza(type)
  if type == 'cheese'
    pizza = CheesePizza.new
  elsif type == 'greek'
    pizza = GreekPizza.new
  elsif type == 'pepperoni'
    pizza = PepperoniPizza.new
  elsif type == 'clam'
    pizza = ClamPizza.new
  # 새로운 피자가 추가/삭제될때 마다 코드를 계속 변경해야 한다
  end

  pizza.prepare
  pizza.bake
  pizza.cut
  pizza.box
  pizza
end
```

#### 문제점

- 어떤 피자를 만들어야 하는지 인스턴스를 만드는 구상 클래스를 선택하는 부분이 문제가 되고 있다
- 코드의 어느 부분이 변경되고, 어느 부분이 변경되지 않는지 확인했으니 캡슐화해보자

### 간단한 팩토리로 개선해보자

- 객체 생성 코드만 따로 추출해보자
  - 객체 생성을 처리하는 클래스를 팩토리라고 부르자
- 간단한 팩토리는 디자인 패턴이라기보다 프로그래밍에서 자주 사용되는 관용구에 가깝다

```ruby
class SimplePizzaFactory
  def create_pizza(type)
    pizza

    if type == 'cheese'
      pizza = CheesePizza.new
    elsif type == 'greek'
      pizza = GreekPizza.new
    elsif type == 'pepperoni'
      pizza = PepperoniPizza.new
    elsif type == 'clam'
      pizza = ClamPizza.new
    end

    pizza
  end
end
```

```ruby
# main.rb
def order_pizza(type)
  pizza = SimplePizzaFactory.create_pizza(type)

  pizza.prepare
  pizza.bake
  pizza.cut
  pizza.box
  pizza
end
```

- 피자 생성하는 부분을 다른 객체에 위임한 것 같은데 이렇게 캡슐화하면 장점은 무엇일까?
  - 피자 생성하는 부분을 다른 여러 클라이언트에서 사용할 수 있다
  - 이렇게 캡슐화하면 피자 생성 작업을 변경할 때 여기저기 고칠 필요 없이 팩토리 클래스 하나만 수정하면 된다
- 클래스의 정적 메서드(클래스 메서드)를 이용하는 정적 팩토리 기법도 있다
  - 간단하게 사용 가능하지만, 서브 클래스를 생성해서 객체 생성 메서드의 행동을 변경할 수 없다는 단점이 있다

#### 문제 상황
- 지점마다 피자를 굽는 방식이 다르거나, 피자를 자르지 않거나, 다른 피자 상자를 사용하는 경우가 생겼다

#### 문제 해결
- 피자 가게와 피자를 만드는 과정을 하나로 묶어야 한다

#### 각 서브 클래스에서 어떤 피자를 만들지 결정하도록 하자
- 서브 클래스에서 결정하도록 피자 가게 프레임워크를 만들어보자
- 각 지점마다 달라질 수 있는 것은 피자 스타일 뿐이다
  - 뉴옥 스타일 피자는 빵이 얇고, 시카고 피자는 빵이 두꺼운 식

```ruby
class PizzaStore
  attr_reader :pizza

  def order_pizza(type)
    pizza = create_pizza(type)

    pizza.prepare
    pizza.bake
    pizza.cut
    pizza.box
    pizza
  end

  def create_pizza(type)
    raise NotImplementedError
  end
end
```

- 각 지점에서는 `PizzaStore`의 서브클래스를 만들고 지점에 맞게 `#create_pizza` 메서드만 구현하면 된다

```ruby
class NYPizzaStore < PizzaStore
  def create_pizza(item)
    case item
    when 'cheese'
      NyStyleCheesePizza.new
    when 'pepperoni'
      NyStylePepperoniPizza.new
    when 'clam'
      NyStyleClamPizza.new
    when 'veggi'
      NyStyleVeggiePizza.new
    end
  end
end
```
- 이렇게 코드를 작성하면 `PizzaStore`와 `Pizza`는 서로 완전히 분리된다
  - `PizzaStore#order_pizza` 메서드에서 `Pizza` 객체를 이용해 여러가지 작업을(피자 굽고, 자르고, 포장) 실제 동작은 어떤 구상 클래스(서브 클래스)에서 처리되는지 알 수 없기 때문 (어떤 피자가 만들어지는지 알 수 없음)
- 피자의 종류는 어떤 서브클래스를 선택했느냐에 따라 결정된다

#### 팩토리 메서드

- 팩토리 메서드 패턴은 객체를 생성할 때 필요한 인터페이스를 만든다. 어떤 클래스의 인스턴스를 만들지는 서브클래스에서 결정한다. 팩토리 메서드 패턴을 사용하면 클래스 인스턴스 만드는 일을 서브클래스에게 맡기게 된다.
-  팩토리 메서드는 객체 생성을 서브클래스에 캡슐화해서 객체를 생성하는 코드와 사용하는 코드를 분리할 수 있다
- 객체 생성 코드를 전부 한 곳으로 분리하여 중복되는 내용을 제거할 수 있고, 유지보수시에 유리하다


```java
abstract Product factoryMethod(String type)
```
- 팩토리 메서드를 추상 메서드로 선언해 서브 클래스가 객체 생성을 책임진다
- 팩토리 메서드는 특정 객체를 리턴하는데, 그 객체는 보통 슈퍼클래스가 정의한 메서드 내에서 사용된다
- 팩토리 메서드는 클라이언트(`PizzaStore`를 인스턴스 생성, `#order_pizza` 호출하는 `main.rb` 같은 코드)에서 실제로 생성되는 구상 객체가 무엇인지 알 수 없게 만드는 역할을 한다
- 팩토리 메서드를 만들 때 매개변수로 만들 객체 종류를 선택할 수 있다

![image](https://github.com/jwowo/study/assets/72483138/7626302d-3ced-4b2b-ad4f-e89a3e1f8eef)

- 팩토리 메소드 패턴은 서브클래스에서 어떤 클래스를 만들지 결정함으로써 객체 생성을 캡슐화한다

#### Creator(PizzaStore)/Product(Pizza) 클래스
- 추상 생산자 클래스가 있고, 나주엥 서브클래스에서 객체를 생산하려고 구현하는 팩토리 메서드를 정의한다
- 생산자 클래스에 추상 제품 클래스에 의존하는 코드가 들어 있을 수 있다
- 제품 클래스의 객체는 클래스의 서브클래스에 의해 만들어지기 때문에 생산자 자체는 어떤 구상 제품 클래스가 만들어질지 미리 알 수 없다
- Pizza(Product)와 PizzaStore(Creator)이 두 클래스는 병렬로 구성되어 있는 여러 서브클래스(뉴욕, 시카고, LA 피자/스토어)들을 가지고 있다. 팩토리 메서드는 이러한 다양한 클래스를 생성하는 방법을 캡슐화하는데 핵심적인 역할을 한다

### 의존성 뒤집기

![image](https://github.com/jwowo/study/assets/72483138/edb3e0fe-e8ca-4b87-a230-256091616e03)

- 객체 인스턴스를 직접 만들면 구상 클래스에 의존해야 한다
- 현재 코드는 모든 피자들이 `PizzaStore`에 의존하고 있다
- 추상화된 것에 의존하게 만들고 구상 클래스에 의존하지 않도록 의존성 뒤집기를 해보자

![image](https://github.com/jwowo/study/assets/72483138/a9ce18ae-d456-4aba-8825-6f807f0324bc)

### 의존성 뒤집기 원칙을 지키는 방법
- 변수에 구상 클래스의 레퍼런스를 저장하지 말기
- 구상 클래스에서 유도된 클래스 만들지 않기
  - 구상 클래스에서 유도된 클래스를 만들면 특정 구상 클래스에 의존하게 된다. 인터페이스나 추상 클래스처럼 추상화된 것으로 부터 클래스를 만들어야 한다
- 베이스 클래스에 이미 구현되어 있는 메서드를 오버라이드하지 말기
  - 이미 구현되어 있는 메서드를 오버라이드한다면 베이스 클래스가 제대로 추상화되지 않는다. 베이스 클래스에서 메서드를 정의할 때는 모든 서브 클래스에서 공유할 수 있는 것만 정의해야 한다