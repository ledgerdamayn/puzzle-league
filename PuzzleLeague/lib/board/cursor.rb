=begin

     TO-DO: Check for valid swap
            Movement

=end
class Cursor
     
     
     attr_accessor :cursor , :relX , :relY , :absX , :absY , :parent , :moved , :swapping
     
     
     def initialize( parent , block_size )
          length = block_size / 3.0
          @parent = parent
          
          @cursor = PL::sketch.createGraphics( block_size * 2 , block_size )
          @cursor.beginDraw()
          @cursor.strokeWeight( PL::CURSOR_THICKNESS )
          @cursor.stroke( PL::colors[ "WHITE" ] , PL::CURSOR_OPACITY )
          
          @cursor.line( 0 , 0 , 0  , length )
          @cursor.line( 0 , 0 , length , 0 )
          
          @cursor.line( 0 , block_size , length  , block_size )
          @cursor.line( 0 , block_size , 0  , block_size - length )
          
          @cursor.line( block_size * 2 , 0 , block_size * 2 - length  , 0 )
          @cursor.line( block_size * 2 , 0 , block_size * 2 , length )
          
          @cursor.line( block_size * 2 , block_size , block_size * 2 - length  , block_size )
          @cursor.line( block_size * 2 , block_size , block_size * 2 , block_size - length )
          
          @cursor.line( block_size - length , 0 , block_size + length  , 0 )
          @cursor.line( block_size , 0 , block_size  , length )
          
          @cursor.line( block_size - length , block_size , block_size + length  , block_size )
          @cursor.line( block_size , block_size , block_size , block_size - length )
          
          @cursor.endDraw()
          
          @relX = PL::CURSOR_DEFAULT_COLUMN * block_size
          @relY = PL::CURSOR_DEFAULT_ROW * block_size
          @moved = false
          @swapping = false
     end
     
     
     # Prevents cursor from becoming misaligned with the board
     # Snaps cursor down if it rises above the top row
     def snapToGrid
          gridHeight = @parent.height - ( ( @parent.height - @parent.offset ) % @parent.block_size )
          
          @relY = [ @relY , gridHeight ].min
          @relY = [ @relY , @parent.offset + @parent.block_size ].max  
     end
     
     
     def swap
          p = getGridPosition
          
          # Validate swap
          return false if p[0] >= @parents.blocks[0].size
          
          col1 = p[0]
          col2 = p[0] + 1
          row = p[1]
                    
          block1 = @parent.block( @parent.blocks[ col1 ][ row ] )
          block2 = @parent.block( @parent.blocks[ col2 ][ row ] )
          
          validStates = [ PL::NORMAL , PL::FALLING ]
          
          return false if ( block1.nil? && block2.nil? )
          return false if ( block1.nil? && !validStates.include?( block2.state ) )
          return false if ( block2.nil? && !validStates.include?( block1.state ) )
          return false unless ( validStates.include?( block1.state ) && validStates.include?( block2.state ) )
          
          @parents.swapping = [ @parent.blocks[ col1 ][ row ] , @parent.blocks[ col2 ][ row ] ]
          
          # Swap logic
          speed = @parent.block_size / ( PL::SWAP_TIME / 1000.0 )
          if ( block1.nil? )
               return false unless ( @parent.blockAbove( col1 , row ).nil? )
               block2.v_x = 0.0 - speed
               block2.state = PL::SWAPPING
          elsif ( block2.nil? )
               return false unless ( @parent.blockAbove( col2 , row ).nil? )
               block1.v_x = speed
               block1.state = PL::SWAPPING
          else
               block1.v_x = speed
               block2.v_x = 0.0 - speed
               block1.state = PL::SWAPPING
               block2.state = PL::SWAPPING
          end
          
          return true
     end
     
     
     def handleInput( key , keyCode )
          if ( key == Processing::App::CODED )
               if ( keyCode == 32 && @parent.swapping.empty? ) #Space
                    swap
               elsif ( !@moved )
                    case keyCode
                    when Processing::App::UP
                         @relY += @parent.block_size ; @moved = true
                    when Processing::App::DOWN
                         @relY -= @parent.block_size ; @moved = true
                    when Processing::App::LEFT
                         @relX -= @parent.block_size ; @moved = true
                    when Processing::App::RIGHT
                         @relX += @parent.block_size ; @moved = true
                    end
               end
               
               
          end
     end
     
     
     def getGridPosition
          return @relX / @parent.block_size , ( @relY - @parent.offset ) / @parent.block_size 
     end
     
     
     
     def draw( frame , timeElapsed )
          @relX = [ @parent.width - @parent.block_size * 2 , @relX ].min
          @relX = [ 0 , @relX ].max
          
          snapToGrid
          
          frame.image( @cursor , @relX , @parent.height - @relY ) 
          
          @moved = false
     end
     
end
