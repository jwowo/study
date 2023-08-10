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