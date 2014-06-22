require 'ruby-processing'
require_relative '../board/block'
require_relative '../subsystems/physics'
require_relative '../board/block_factory'
require_relative '../board/board'
require_relative '../super/frame'
require_relative '../super/level'
require_relative '../super/scene'
require_relative '../board/combo'
require_relative '../board/cursor'
require_relative '../subsystems/collision'
require_relative 'game'


module PL
     
         
     class Sketch < Processing::App
          
          @@sketch = nil
          @@game = nil
          @@colors = {}
          @@block_size = nil
          
          attr_accessor :timeElapsed , :previousFrameTimestamp , :frameDuration
          
          def setup
               size( DEFAULT_SCREENSIZE , DEFAULT_SCREENSIZE )
               
               noStroke
               colorMode( RGB , 255 )
               frameRate( FRAMERATE )
               
               @timeElapsed = millis()
               @timeSinceLastFrame = 0
               @frameDuration = 1000.0 / FRAMERATE
               
               @@sketch = self
               
               @@colors[ "WHITE" ] = color( 255 , 255 , 255 )
               @@colors[ "BLACK" ] = color( 0 , 0 , 0 )
               @@colors[ "GRAY" ] = color( 180 , 180 , 180 )
               
               @@colors[ "PURPLE" ] = color( 255 , 0 , 127 )
               @@colors[ "GREEN" ] = color( 0 , 153 , 0 )
               @@colors[ "BLUE" ] = color( 0 , 0 , 255 )
               @@colors[ "RED" ] = color( 255 , 0 , 0 )
               @@colors[ "YELLOW" ] = color( 255 , 255 , 0 )
               
               background( @@colors[ DEFAULT_BACKGROUND ] )
          end
          
          
          def draw
               # How many milliseconds since the beginning of the previous frame
               @timeSinceLastFrame = millis() - @timeElapsed
               @previousFrameTimestamp = @timeElapsed
               @timeElapsed = millis()
               
               # Enforce framerate cap
               @@game.draw( @previousFrameTimestamp ) if ( @timeSinceLastFrame >= @frameDuration )    
          end
          
          
          def keyPressed()
               @@game.handleInput( key , keyCode )
          end
          
          
          def self.sketch() @@sketch end
          def self.sketch=( sketch ) @@sketch = sketch end
          def self.game() @@game end  
          def self.game=( game ) @@game = game end
          def self.colors() @@colors end
          def self.block_size() @@block_size end
          def self.block_size=( block_size ) @@block_size = block_size end
          
          
     end
     
     
     def self.sketch() return Sketch.sketch end
     def self.colors() return Sketch.colors end
     def self.millis() return ( sketch.nil? ) ? 0 : sketch.millis end
     def self.block_size() return Sketch.block_size end
     
     
     # Constants
     DEFAULT_SCREENSIZE = 500
     DEFAULT_BACKGROUND = "BLACK"
     FRAMERATE = 30
     
     CURSOR_THICKNESS = 4
     CURSOR_OPACITY = 200
     CURSOR_DEFAULT_ROW = 4
     CURSOR_DEFAULT_COLUMN = 3
     
     GRAVITY = 1.0 # Blocks/sec/sec
     TERMINAL_VELOCITY = 5 # Blocks/sec
     
     RISE_ACCELERATION = 0.5 # Blocks/sec/sec
     
     BOARD_WIDTH_PERCENT = 0.4
     BOARD_HEIGHT_PERCENT = 0.80
     DEFAULT_FRAME_BACKGROUND = "GRAY"
     
     COMBO_REMOVE_RATE = 2 # Blocks/sec
     SWAP_TIME = 250 # Milliseconds
     
     RESERVED_BLOCKS = 500
     BLOCK_ROUNDING = 10
     
     BLOCK_NORMAL = 0
     INACTIVE = 0
     BUFFER = 1
     NORMAL = 2
     FALLING = 3
     COMBO = 4
     SWAPPING = 5
           
     NORMAL_COLORS = [ "PURPLE" , "GREEN" , "BLUE" , "RED" , "YELLOW" ]                    
     
end