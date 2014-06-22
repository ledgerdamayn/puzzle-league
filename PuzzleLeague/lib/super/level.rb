=begin

     A Level is a container for a board state (both initial state and current).
     Contains parameters for generating the board and its properties:
          e.g. win/loss conditions, block rise acceleration, board width, assets (textures, sounds, etc.)
     
     Converts user input into board actions.
     
=end


require_relative 'frame'


class Level < Frame
     
     
     attr_accessor :blockCount , :board
     
       
     def initialize( label , blockCount , xOffsetPercent , yOffsetPercent )
          super( label , PL::BOARD_WIDTH_PERCENT , PL::BOARD_HEIGHT_PERCENT , xOffsetPercent , yOffsetPercent )
          
          @blockCount = blockCount
          @board = Board.new( self , blockCount )
     end
     
     # Adds a block above the top block in the column
     def addBlock( column )
          @board.addBlock( column )
     end
     
     
     def bufferRow
          @board.bufferRow
     end
     
     
     def draw( timeElapsed )
          @frame.beginDraw()
          @frame.background( PL::colors[ @background_color ] )
          
          @board.draw( @frame , timeElapsed ) # Updates frame object
          PL::sketch.image( @frame , @x , @y )
          @frame.clear
     end
     
     
     def handleInput( key , keyCode )
          @board.cursor.handleInput( key , keyCode )
     end
     
     
end
