# 커맨드 패턴

> 메서드 호출을 캡슐화해보자
커맨드 패턴을 사용하면 요청 내역을 객체로 캡슐화해서 객체를 서로 다른 요청 내역에 따라 매개변수화할 수 있다. 이렇게 하면 요청을 큐에 저장하거나 로그로 기록하거나 작업 취소 기능을 사용할 수 있다



### 시나리오 개요

- 만능 IOT 리모컨을 만들어보자
- 리모컨에는 그냥 ON/OFF 버튼만 있지만, 협력 업체에서 제공한 클래스는 다양한 메소드를 가지고 있고, 다른 제품이 추가될 수 있다
- 리모컨의 각 슬롯을 한 가지 기기 또는 하나로 엮여 있는 일련의 기기에 할당할 수 있ㅗ록 해는 API를 제작해보자
- 새로운 클래스가 추가될때마다 리모컨에 코드를 고치는 것은 좋지 않다. 버그가 생길 가능성도 높아지고 매번 수정해야 하는 코드가 늘어난다
- 커맨트 패턴을 통해 작업을 요청하는 쪽과 그 작업을 처리하는 쪽을 분리하자
  - 리모컨이 협력 업체가 제공한 클래스를 자세히 알 필요가 없게 하자

### 객체 마을 식당

![image](https://github.com/jwowo/study/assets/72483138/4f28a4bb-f550-4882-9efc-22dbf61b7aab)

- 객체 마을 식당에서 음식을 주문해보자
  - 고객 → 주문서 → 종업원 → 주방장
- 주문서는 주문 내용을 캡슐화한다.
    - 주문서는 주문 내용을 요구하는 객체이다.
- 종원원은 주문서를 받고 orderUp() 메서드를 호출한다
    - 주문서에 어떤 내용이 있는지, 고객이 누구인지 알 필요가 없다
- 주방장은 식사를 준비하는데 필요한 정보를 가지고 음식을 만든다
    - 주방장과 종업원은 완전히 분리되어 있다

### 객체 마을 식당 커맨드 패턴(인보커 로딩)

![image](https://github.com/jwowo/study/assets/72483138/45eeeac0-d89c-44ad-a0c4-bc447e592749)

```ruby
{
  '인보커 객체' : '종업원',
  '리시버 객체' : '주방장',
  'execute' : 'orderUp()',
  '커맨드 객체' : '주문서',
  '클라이언트 객체' : '고객',
  'setCommand' : 'takeOrder()'
}
```
1. 클라이언트(고객)는 커맨드 객체(주문서)를 생성한다
  - 커맨드 객체는 리시버(주방장)에 전달할 일련의 행동을 가지고 있다
2. `setCommand()`를 호출해서 인보커(종업원)에 커맨드 객체를 저장한다
3. 나중에 클라이언트에서 인보커에게 그 명령을 실행하라고 요청한다
(참고) 어떤 명령을 인보커에 로딩한 다음 한번만 작업을 처리하고 커맨드 객체를 지우도록 할 수도 있고, 저장해둔 명령을 여러 번 수행하게 할 수도 있다

### 커맨드 객체 만들기

- 커맨드 객체는 일련의 행동을 특정 리시버와 연결함으로써 요청을 캡슐화한 것이다
- 커맨트 패턴을 사용하면 특정 인터페이스만 구현되어 있을때 그 커맨드 객체에서 실제로 어떤 일을 하는지 신경 쓸 필요가 없다

```ruby
class Command
  def execute
    raise NotImplementedError
  end
end
```
```ruby
class LightOnCommand < Command
  def initialize(light)
    @light = light
  end

  attr_reader :light

  def execute
    light.on
  end
end
```
```ruby
class SimpleRemoteControl
  def initialize
    @command
  end

  attr_accessor :command

  def button_pressed
    command.execute
  end
end
```
```ruby
remote = SimpleRemoteControl.new
light = Light.new
light_on = LightOnCommand.new(light)

remote.command = light_on
remote.button_pressed
```

### 커맨드 패턴 클래스 다이어그램

![image](https://github.com/jwowo/study/assets/72483138/e1a7f9f2-6e93-48c7-a791-fdc77902722b)

### 리모컨 슬롯에 명령 할당하기
- 리모컨의 각 슬롯에 명령을 할당해보자(리모컨이 인보커가 되는 것)
- 사용자가 버튼을 누르면 그 버튼에 맞는 커맨드 객체의 `execute()` 메서드가 호출되고, 리시버(조명, 선풍기, 오디오 등)에서 특정 행동을 담당하는 메서드가 실행된다

