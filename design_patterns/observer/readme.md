# 옵저버 패턴

## 시나리오 개요

- `WeatherData` 클래스에는 3가지 측정값(온도, 습도, 기압) 이 있다
- 새로운 기상 측정 데이터가 들어올 때마다 `#measurement_changed` 메서드 호출된다

## 목표

- 기상 데이터를 사용하는 디스플레이 요소 3가지를 구현해야 한다
- `WeatherData`에서 새로운 측정값이 들어올 때마다 디스플레이를 갱신해야 한다

### 추가 목표

- 확장성을 고려해서 코드를 작성하자
  - 사용자 마음대로 디스플레이 요소를 더하거나 뺄 수 있도록 하자
    (온도, 습도, 기압 외의 다른 데이터/디스플레이가 추가될 수 있다)

```ruby
class WeatherData
  def initialize
    @current_condition_display = CurrentConditionsDisplay.new
    @statistics_display = StatisticsDisplay.new
    @forecast_display = ForecastDisplay.new
  end

  # 온도, 습도, 기압을 어떻게 알아내는지는 몰라도 된다
  def get_temperature; end

  def get_humidity; end

  def get_pressure; end

  attr_reader :current_condition_display, :statistics_display, :forecast_display

  # 기상 관측값이 갱신될 때마다 이 메소드가 호출된다
  def measurements_changed
    temperature = get_temperature
    humidity = get_humidity
    pressure = get_pressure

    # 어떤 디스플레이가 추가/삭제될때마다 이 부분을 수정해주어야 한다
    current_condition_display.update(temperature, humidity, pressure)
    statistics_display.update(temperature, humidity, pressure)
    forecast_display.update(temperature, humidity, pressure)
  end
end
```

### 문제점

- 추가 목표에서 확장성을 고려해서 코드를 작성하고자 한다
- 디스플레이 업데이트를 하는 부분은 다른 디스플레이 항목을 추가/제거할 때마다 수정해야 한다
- __자주 바뀌는 부분을 추상화할 필요가 있다__

### 공통점

- 공통된 인자(온도, 습도, 기압)를 가지고 업데이트하고 있다

## 옵저버 패턴 이해하기

> 신문사(Subject) + 구독자(Observer) = 옵저버 패턴

- 신문사는 매일 신문을 찍어낸다
- 구독자는 신문사에 구독 신청을 하면, 새로운 신문이 나올때마다 신문을 배달 받을 수 있다
- 구독자가 신문을 더 보고 싶지 않다면 구독 해지 신청을 한다
- 신문사가 망하지 않는 이상 구독자들은 자유롭게 구독을 신청/해지 한다

> 한 객체의 상태가 바뀌면
그 객체에 의존하는 다른 객체에게 연락이 가고
자동으로 내용이 갱신되는 방식으로
일대다 의존성을 정의한다

## 옵저버 패턴의 구조

- 옵저버 패턴은 보통 __주제 인터페이스__ 와 __옵저버 인터페이스__ 가 들어 있는 클래스 디자인으로 구현한다
- 옵저버 패턴에서는 __주제가 상태를 저장하고 제어한다__ 따라서 상태가 들어있는 객체는 하나만 있을 수 있다
- 각 주제마다 __여러 개의 옵저버가 있을 수 있다__
- 각 옵저버는 특정 주제에 등록해서 연락을 받을 수 있다

### 느슨한 결합(Loose Coupling)이란?

- 객체들이 상호작용할 수는 있지만, 서로를 잘 모르는 관계를 의미한다
- 옵저버 패턴은 느슨한 결합을 보여주는 훌륭한 예시이다

### 느슨한 결합의 위력

- 주제는 옵저버의 구상 클래스가 무엇인지, 무엇을 하는지 알 필요가 없다
- 옵저버는 언제든지 새로 추가할 수 있다
- 새로운 형식의 옵저버를 추가할 때도 주제를 변경할 필요가 없다
- 주제와 옵저버는 독립적으로 재사용할 수 있다
- 주제나 옵저버가 달라져도 서로에게 영향을 미치지 않는다
- 느슨하게 결합하는 디자인을 사용하면 객체 사이의 상호 의존성을 최소화할 수 있기 때문에 변경 사항이 생겨도 유연한 객체지향 시스템을 구축할 수 있다

```ruby
# Subject class
class WeatherData
  def initialize
    @temperature
    @humidity
    @pressure
    @observers = []
  end

  attr_accessor :temperature, :humidity, :pressure

  # 측정 값이 갱신되면 옵저버들에게 알려준다
  def measurement_changed
    notify_observers
  end

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    measurement_changed
  end

  # 옵저버 등록
  def add_observer(observer)
    @observers << observer
  end

  # 옵저버 제거
  def delete_observer(observer)
    @observers.delete(observer)
  end

  # 주제의 상태가 변경되었을 떄 모든 옵저버에게 변경 내용을 알리기 위해 호출하는 메서드
  def notify_observers
    @observers.each do |observer|
      observer.update(temperature, humidity, pressure)
    end
  end
end
```

```ruby
class CurrentConditionsDisplay
  def initialize(temperature, humidity)
    @temperature = temperature
    @humidity = humidity
  end

  attr_accessor = :temperature, :humidity

  def update(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    display
  end

  def display
    puts "현재 상태: 온도 #{@temperature}, 습도 #{@humidity} "
  end
end
```

```ruby
weather_data = WeatherData.new
current_conditions_display = CurrentConditionsDisplay.new(10, 11)
current_conditions_display.display
weather_data.add_observer(current_conditions_display)
weather_data.set_measurements(19, 20, 21)

# 현재 상태: 온도 10, 습도 11
# 현재 상태: 온도 19, 습도 20
```

### 참고

- 루비에는 built-in 모듈로 `Observable`을 제공한다
  - https://docs.ruby-lang.org/en/2.2.0/Observable.html
- 자바에도 `Observable` 클래스를 제공했지만 자바 9 이후로는 쓰이지 않는다
  - 자신의 코드에서 기본적인 옵저버 패턴을 지원하는 게 더 편하다
  - 더 강력한 기능을 스스로 구현하는 게 낫겠다
    고 생각하는 사람들이 늘어나면서 더 이상 사용되고 있지 않다

### `Observable`을 이용해서 리팩터링한 코드

```ruby
require 'observer'

class WeatherData
  include Observable

  def initialize
    @temperature
    @humidity
    @pressure
  end

  attr_accessor :temperature, :humidity, :pressure

  def measurement_changed
    changed
    notify_observers(temperature, humidity, pressure)
  end

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    measurement_changed
  end
end

class CurrentConditionsDisplay
  def initialize(temperature, humidity)
    @temperature = temperature
    @humidity = humidity
  end

  attr_accessor = :temperature, :humidity

  def update(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    display
  end

  def display
    puts "현재 상태: 온도 #{@temperature}, 습도 #{@humidity} "
  end
end

weather_data = WeatherData.new
current_conditions_display = CurrentConditionsDisplay.new(10, 11)
current_conditions_display.display
weather_data.add_observer(current_conditions_display)
weather_data.set_measurements(19, 20, 21)

# 현재 상태: 온도 10, 습도 11
# 현재 상태: 온도 19, 습도 20
```

### 풀 방식으로 옵저버 패턴 구현하기

- 옵저버 패턴 구현 방법에는 Push/Pull 이 있다
  - Push : 주제가 옵저버에게 상태를 알리는 방식
  - Pull : 옵저버가 주제로 부터 상태를 끌어오는 방식
- 일반적으로 옵저버가 필요한 데이터를 가져가도록 하는 Pull 방법이 더 좋다
  - 시간이 지날수록 애플리케이션은 변경되고 복잡해지기 때문
  - 옵저버가 필요할 때마다 주제에서 데이터를 끌어오면 코드를 조금 더 일반화할 수 있다
    - 변경에 열려있게 된다

```ruby
# Subject

class WeatherData
  def initialize
    @temperature
    @humidity
    @pressure
    @observers = []
  end

  attr_accessor :temperature, :humidity, :pressure

  def measurement_changed
    notify_observers
  end

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    measurement_changed
  end

  def add_observer(observer)
    @observers << observer
  end

  # 옵저버의 update 메서드를 인자 없이 호출
  def notify_observers
    @observers.each do |observer|
      observer.update
    end
  end
end
```

```ruby
# Observer

class CurrentConditionsDisplay
  # 생성자로 들어온 WeatherData를 통해 옵저버 등록
  def initialize(weather_data)
    @temperature
    @humidity
    @weather_data = weather_data
    weather_data.add_observer(self)
  end

  attr_accessor = :temperature, :humidity, :weather_data

  # 1. 옵저버에서 update 메서드에 매개변수가 없도록 변경
  # 2. WeatherData 의 게터 메서드로 주제의 날씨 데이터를 가져오도록 Observer 구상 클래스를 수정
  def update
    @temperature = @weather_data.temperature
    @humidity = @weather_data.humidity
    display
  end

  def display
    puts "현재 상태: 온도 #{@temperature}, 습도 #{@humidity} "
  end
end
```

```ruby
weather_data = WeatherData.new
current_conditions_display = CurrentConditionsDisplay.new(weather_data)
weather_data.set_measurements(1, 2, 3)
weather_data.set_measurements(4, 5, 6)

# 현재 상태: 온도 1, 습도 2
# 현재 상태: 온도 4, 습도 5
```

## 옵저버 패턴에서의 디자인 원칙

- 애플리케이션에서 변하는 부분을 찾고, 변하지 않는 부분과 분리하여 캡슐화하자
  - 옵저버 패턴에서 변하는 것은 주제의 상태와 옵저버의 개수, 형식이다
  - 주제를 바꾸지 않고도 주제의 상태에 객체들을 바꿀 수 있다
- 구현보다는 인터페이스에 맞춰서 프로그래밍하자
  - 주제와 옵저버에서 인터페이스를 사용하고, 인터페이스를 통해 옵저버 등록/탈퇴를 관리하여 느슨한 결합을 만들자
  - 주제는 옵저버가 Observer 인터페이스를 구현한다는 것외에 어떤 일을 하는지 모르기 때문에 느슨한(유연한) 결합이라고 할 수 있다
- 상속보다는 구성을 활용하자
  - 주제와 옵저버 사이의 관계를 상속이 아닌 구성으로 구성하자
