# 어댑터 패턴

> 어댑터 패턴은 특정 클래스 인터페이스를 클라이언트에서 요구하는 다른 인터페이스로 변환한다. 인터페이스가 호환되지 않아 같이 쓸 수 없었던 클래스를 사용할 수 있게 도와준다

![image](https://github.com/jwowo/study/assets/72483138/be964956-62cc-4cea-b7d6-ff4b74a2ec26)

### 클라이언트에서 어댑터를 사용하는 방법

1. 클라이언트에서 타깃 인터페이스로 메소드를 호출해서 어댑터에 요청을 보낸다
2. 어댑터는 어댑티 인터페이스로 그 요청을 어댑티에 관한 (하나 이상의) 메소드 호출로 변환한다
3. 클라이언트는 호출 결과를 받긴 하지만 중간에 어댑터가 있다는 사실을 모른다

```ruby
class MallardDuck < Duck
  def quack
    puts '꽥'
  end

  def fly
    puts '날고 있어요'
  end
end
```
```ruby
class WildTurkey < Turkey
  def gobble
    puts '골골'
  end

  def fly
    puts '짧은 거리를 날고 있어요'
  end
end
```
```ruby
class TurkeyAdapter < Duck
  def initialize(turkey)
    @turkey = turkey
  end

  attr_reader :turkey

  def quack
    turkey.gobble
  end

  def fly
    5.times { turkey.fly }
  end
end
```
```ruby
turkey = WildTurkey.new
turkey_adapter = TurkeyAdapter.new(turkey)
turkey_adapter.quack # '골골'
turkey_adapter.fly # '짧은 거리를 날고 있어요'
```

### 어댑터 패턴의 장점

- 클라이언트와 구현된 인터페이스를 분리할 수 있으며, 변경 내역이 어댑터에 캡슐화되기 때문에 나중에 인터페이스가 변경되어도 클라이언트를 변경할 필요가 없다
- 어댑티를 새로 바뀐 인터페이스로 감쌀 때는 객체 구성을 사용한다
  - 어댑티의 모든 서브클래스에 어댑터를 사용할 수 있다
