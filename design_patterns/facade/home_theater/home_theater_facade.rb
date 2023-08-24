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