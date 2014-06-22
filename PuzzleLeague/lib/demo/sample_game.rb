require_relative '../main/main'
require_relative 'test_level'
require_relative 'test_scene'

class SampleGame < Game
    
     attr_accessor :cursor
     
     
     def initialize
         super
         @active_scene = "TEST"
         @scenes[ @active_scene ] = TestScene.new
     end
    
     
     def draw( timeElapsed )
          @scenes[ @active_scene ].draw( timeElapsed ) if !@scenes[ @active_scene ].nil?
     end
     
end


game = SampleGame.new