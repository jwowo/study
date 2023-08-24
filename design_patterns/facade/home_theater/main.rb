require_relative 'home_theater_facade'

home_theater_facade = HomeTheaterFacade.new(amp, tuner, player, projecter, screen, lights, popper)
home_theater_facade.watch_movie("인디아나 존스")
home_theater_facade.end_movie
