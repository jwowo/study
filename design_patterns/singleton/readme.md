# 싱글턴 패턴
> 하나뿐인 특별한 객체를 만들어보자

- 스레드, 캐시, 로그 기록용 객체, 디바이스 드라이버등 인스턴스가 2개 이상이면 프로그램이 의도대로 동작하지 않거나, 자원을 불필요하게 사용하는 등의 문제가 생길 수 있는 객체가 있다.
- 싱글턴 패턴은 특정 클래스에 객체 인스턴스가 하나만 만들어지도록 해주는 패턴이다
- 싱글턴 패턴을 사용하면 전역 변수를 사용할 때와 같이 객체 인스턴스를 어디에서든 액세스할 수 있게 만들 수 있고, 전역 변수를 쓸 때처럼 여러 단점을 감수할 필요가 없다
  - 필요할 때만 객체를 만들 수 있어 쓸데없는 자원을 잡아먹지 않도록 할 수 있다
- 싱글턴 패턴은 인스턴스가 하나 뿐이므로 한 어플리케이션에 들어있는 어떤 객체에서도 같은 자원을 활용할 수 있다. 연결 풀이나 스레드 풀과 같은 자원풀을 관리하는데도 자주 사용된다
- public 생성자가 없고 get 정적(클래스) 메서드를 통해 인스턴스를 생성하도록 구현하는 것이 특징이다
- 실제 적용할 때는 클래스에 하나뿐인 인스턴스를 관리하도록 만들고 다른 어떤 클래스에서도 자신의 인스턴스를 추가로 만들지 못하게 해야 한다. 인스턴스가 필요하다면 클래스 자신을 거치도록 한다
- 어디서든 인스턴에서 접근할 수 있도록 전역 접근 지점을 제공한다. 클래스 메서드를 통해 lazy loading 방식으로 객체를 생성하여 자원 낭비를 줄일 수 있다


### 고전적인 싱글턴 패턴 구현
```ruby
class Singleton
  @@instance = Singleton.new

  def self.instance
    @@instance
  end

  private_class_method :new
end
```
- `@@instance`는 클래스 변수(정적 변수)로 하나뿐인 인스턴스를 저정한다
- 생성자를 private으로 선언했으므로 `Singleton`에서만 클래스의 인스턴스를 만들 수 있다
- `.instance` 메서드는 클래스의 인스턴스를 반환한다

## 초콜릿 보일러 코드

### 시나리오 개요
- 초콜릿 공장에서 초콜릿을 끓이는 장치를 컴퓨터로 제어한다
- 초콜릿 보일러는 초콜릿과 우유를 받아서 끓이고 초코바를 만드는 단계로 넘겨준다
- 아직 끓지 않은 재료를 그냥 흘리거나, 보일러가 가득 차 있는 상태에서 새로운 재료를 붓는다거나, 빈 보일러에 불을 지핀다는 드으이 실수를 하지 않도록 코드를 작성했다
```ruby
class ChocolateBoiler
  @@instance = nil

  def initialize
    @empty = true
    @boiled = false
  end

  attr_accessor :empty, :boiled

  def self.instance
    return @@instance if @@instance

    @@instance = new
    @@instance
  end

  def fill
    return unless empty

    empty = false
    boiled = false
  end

  def drain
    empty = treu if !empty && boiled
  end

  def boil
    boiled = true if !empty && !boiled
  end

  private_class_method :new
end
```
- `ChocolateBoiler` 인스턴스 2개가 따로 돌아가면 문제가 발생할 수 있다
- 이렇게 고전적인 싱글턴 패턴으로 구현했는데 인스턴스 2개가 생길 수 있을까?
  - 멀티스레딩 환경에서 동기화 문제가 생길 수 있다

### 멀티스레딩 문제
- 2개의 스레드에서 위 초콜릿 보일러 코드를 실행해보자
- `self.instance` 내에서 동기화하면 멀티스레딩 관련 문제가 해결된다
```ruby
class ThreadSafeChocolateBoiler
  @@mutex = Mutex.new
  @@instance = nil

  def initialize
    @empty = true
    @boiled = false
  end

  attr_accessor :empty, :boiled

  def self.instance
    return @@instance if @@instance

    @@mutex.synchronize do
      @@instance ||= new
    end

    @@instance
  end

  def fill
    return unless empty

    empty = false
    boiled = false
  end

  def drain
    empty = treu if !empty && boiled
  end

  def boil
    boiled = true if !empty && !boiled
  end

  private_class_method :new
end
```
- 사실 위 코드에서 동기화가 꼭 필요한 시점은 `self.instance`가 시작될 때 이다
  - 처음부터 `@@instance = ThreadSafeChocolateBoiler.new`로 선언해주면 메서드를 동기화할 필요가 없다

#### 효율적으로 멀티스레딩 문제 해결하기
1. `.instance`의 속도가 중요하지 않다면 그냥 유지한다
  - 다만 메서드를 동기화하면 성능이 100배 정도 저하될 수 있다
```ruby
class ChocolateBoiler
  @@instance = nil
  @@mutex = Mutex.new

  def self.instance
    return @@instance if @@instance

    @@mutex.synchronize do
      unless @@instance
        @@instance = new
      end
    end

    @@instance
  end
end
```
2. 필요할때 lazy-loading하지 않고 처음부터 인스턴스를 생성한다
  - 클래스가 로딩될 때 알아서 클래스의 하나뿐인 인스턴스를 생성해준다
  - 다만 사용하지 않아도 자원을 사용한다는 단점이 있다
```ruby
class ChocolateBoiler
  @@instance = ChocolateBoiler.new
end
```
3. DCL(Double-Checked Locking)을 사용하여 동기화되는 부분을 줄인다
