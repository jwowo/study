# 옵저버 패턴

### 시나리오 개요

- `WeatherData` 클래스에는 3가지 측정값(온도, 습도, 기압)이 있다
- 새로운 기상 측정 데이터가 들어올 때마다 `#measurement_changed` 메서드 호출된다

### 목표

- 기상 데이터를 사용하는 디스플레이 요소 3가지를 구현해야 한다
- `WeatherData`에서 새로운 측정값이 들어올 때마다 디스플레이를 갱신해야 한다

#### 추가 목표

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

  # 온도, 습도. 기압을 어떻게 알아내는지는 몰라도 된다
  def get_temperature; end

  def get_humidity; end

  def get_pressure; end

  attr_reader :current_condition_display, :statistics_display, :forecast_display

  # 기상 관측값이 갱신될 때마다 이 메소드가 호출된다
  def measurements_changed
    temperature = get_temperature
    humidity = get_humidity
    pressure = get_pressure

    current_condition_display.update(temperature, humidity, pressure)
    statistics_display.update(temperature, humidity, pressure)
    forecast_display.update(temperature, humidity, pressure)
  end
end
```

#### 문제점
- 추가 목표에서 확장성을 고려해서 코드를 작성하고자 했다
- 각종 업데이트를 하는 부분은 다른 디스플레이 항목을 추가하거나 제거할때마다 수정해야 한다
- 자주 바뀌는 부분을 추상화할 필요가 있다

#### 공통점
- 공통된 인자를 가지고 업데이트하고 있다(온도, 습도, 기압)

---

### 옵저버 패턴 이해하기

> 신문사(Subject) + 구독자(Observer) = 옵저버 패턴

- 신문사는 매일 신문을 찍어낸다
- 구독자는 신문사에 구독 신청을 하면, 새로운 신문이 나올때마다 신문을 배달 받을 수 있다
- 구독자가 신문을 더 보고 싶지 않다면 구독 해지 신청을 한다
- 신문사가 망하지 않는 이상 구독자들은 자유롭게 구독을 신청/해지 한다

> 한 객체의 상태가 바뀌면 그 객체에 의존하는 다른 객체에게 연락이 가고 자동으로 내용이 갱신되는 방식으로 일대다 의존성을 정의한다.

### 옵저버 패턴의 구조

- 옵저버 패턴은 보통 주제 인터페이스와 옵저버 인터페이스가 들어 있는 클래스 디자인으로 구현한다.
- 옵저버 패턴에서는 주제가 상태를 저장하고 제어한다. 따라서 상태가 들어있는 객체는 하나만 있을 수 있다.
- 각 주제마다 여러 개의 옵저버가 있을 수 있다
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