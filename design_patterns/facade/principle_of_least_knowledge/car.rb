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
