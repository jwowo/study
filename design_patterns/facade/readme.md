# 퍼사드 패턴

> 퍼사드 패턴은 서브시스템에 있는 일련의 인터페이스를 통합 인터페이스로 묶어준다. 또한 고수준 인터페이스도 정의하므로 서브시스템을 더 편리하게 사용할 수 있다

- 퍼사드 패턴은 인터페이스를 단순하게 바꾸기 위해 인터페이스를 변경한다
- 퍼사드(facade)는 겉모양이나 외관이라는 뜻이다

## 홈시어터 만들기

- 스트리밍 플레이어, 프로젝터, 자동 스크린, 서라운드 음향, 팝콘 기계 등의 시스템을 갖춘 홈시어터를 구축해보자

### 문제 상황

- 영화를 보려면 해야할 일들이 너무 많다
  1. 팝콘 기계를 켠다
  2. 팝콘을 튀긴다
  3. 조명을 어둡게 조절한다
  4. 스크린을 내린다
  4. 프로젝터를 켠다
  ...
- 영화는 아직 시작도 안했네...
- 퍼사드 패턴으로 간단하게 처리해보자

### 퍼사드 작동 원리

- 쓰기 쉬운 인터페이스를 제공하는 퍼사드 클래스를 구현해서 복잡한 시스템을 편리하게 사용하자
- 퍼사드 클래스는 홈시어터 구성 요소를 하나의 서브시스템으로 간주하고, 퍼사드에서 제공하는 인터페이스를 통해 실행되는 메소드(`#watch_movie`)는 서브시스템의 메소드를 호출해서 필요한 작업을 처리한다
  - 클라이언트는 서브시스템이 아닌 홈시어터 퍼사드 메소드를 호출한다
  - `#watch_movie` 를 호출하면 조명, 스트리밍 플레이어, 프로젝터, 앰프, 스크린, 팝콘 기계등이 알아서 준비된다
- 퍼사드는 서브시스템의 기능을 사용할 수 있는 간단한 인터페이스를 제공할 뿐, 서브시스템 클래스를 캡슐화하지 않기 때문에 필요하다면 직접 접근하여 원하는 기능을 수행할 수 있다
  - 직접 팝콘을 튀기고 싶으면 직접 서브시스템에 접근하여 동작하면 된다
- 특정 서브시스템에 대해 만들 수 있는 퍼사드의 개수에는 제한이 없다
- 퍼사드를 사용하면 클라이언트 구현과 서브시스템을 분리할 수 있다
  - 클라이언트에 수정이 필요하다면 퍼사드만 변경하면 된다 (홈시어터 업그레이드)

#### 퍼사드 vs 어댑터

- 퍼사드는 인터페이스를 단순하게 만드는 용도로 사용
- 어댑터는 인터페이스를 다른 인터페이스로 변환하는 용도로 사용

### 편하게 영화보기

```ruby
class HomeTheaterFacade
  def initialize(amp, player, projector, screen, lights, popper)
    @amp = amp
    @player = player
    @projector = projector
    @screen = screen
    @lights = lights
    @popper = popper
  end

  attr_reader :amp, :player, :projector, :screen, :lights, :popper

  def watch_movie(movie)
    puts '영화 볼 준비 중'
    popper.on
    popper.pop
    lights.dim(10)
    screen.down
    projector.on
    projector.wide_screen_mode
    amp.onamp.set_streaming_sound
    amp.volumn(5)
    player.on
    player.play(movie)
  end

  def end_movie
    puts '영화 볼 준비 중'
    popper.off
    lights.on
    screen.up
    projector.off
    amp.off
    player.stop
    player.off
  end
end
```
```ruby
# amp, tuner 등 영화에 필요한 class 구현은 생략
home_theater_facade = HomeTheaterFacade.new(amp, tuner, player, projecter, screen, lights, popper)
home_theater_facade.watch_movie("인디아나 존스")
home_theater_facade.end_movie
```

## 최소 지식 원칙

> 객체 사이의 상호작용은 될 수 있으면 아주 가까운 '찬구' 사이에만 허용하는 것이 좋다

- 여러 클래스가 복잡하게 얽혀 있어서, 시스템의 한 부분을 변경했을 때 다른 부분까지 계속 고쳐야 하는 상황을 방지할 수 있다
- 최소 지식 원칙의 단점
  - 원칙을 적용하기 위해 시스템이 복잡해지고, 개발 시간도 늘어나고, 성능도 떨어질 수 있다

### 의존성을 최고화하고 다른 객체에 영향력 행사하기

- 가이드 라인을 이용하자
  - 객체 자체
  - 메소드에 매개변수로 전달된 객체
  - 메소드를 생성하거나 인스턴스를 만든 객체
  - 객체에 속하는 구성 요소

### 최소 지식 원칙 적용하기

```ruby
class Car
  def initialize
    @engin = Engin.new # 엔진을 구성 요소로 생성

    # 자동차, 엔진 초기화 등을 처리
  end

  def start(key)
    doors = Doors.new
    authorized = key.turns
    return unless authorized

    engine.start
    update_dashboard_display
    doors.lock
  end

  def update_dashboard_display; end
end
```
