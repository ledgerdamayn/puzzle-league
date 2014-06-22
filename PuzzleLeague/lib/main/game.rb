=begin

     Games are containers for Scene and Level objects. 
     Handles initialization of game subsystems, and game flow.

     TO-DO: Scene/level representation as a config file

=end


class Game
     
     
     attr_accessor :scenes , :active_scene
     
     
     def initialize
          @scenes = Hash.new
          PL::Sketch.game = self
          PL::Sketch.new :title => "Test"  
          BlockFactory.new
     end
     
     
     def draw( timeElapsed )
          @scenes[ @active_scene ].draw( timeElapsed ) if !@scenes[ @active_scene ].nil?
     end
     
     
     def handleInput( key , keyCode )
          @scenes[ @active_scene ].handleInput( key , keyCode )
     end
     
     
end
