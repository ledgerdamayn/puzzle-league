=begin

     A Board controls game flow using parameters provided by its parent Level.
     
     Boards do not handle user inputs directly, instead they receive events via
     their parent Level object.  The same applies for handling events such as win/loss,
     or interactions with other players.

=end

class Board
     
          
     attr_accessor :block_size , :parent , :cursor , :chainCount ,
                   :x , :y , :width , :height , :offset , :timeSinceSwap ,
                   :riseV , :riseA , :paused ,  # Offset increase velocity/acceleration
                   :blocks , :normal , :combos , :falling , :buffer , :swapping
           
     
     def initialize( parent , blockCount )
          @parent = parent
          @x = parent.x
          @y = parent.y
          @width = parent.width
          @height = parent.height
          @offset = 0
          @riseV = 0
          @riseA = PL::RISE_ACCELERATION
          @timeSinceSwap = 0 
          
          @block_size = @width / blockCount
          PL::Sketch.block_size = @block_size
          
          # Array of priority queues of block indices (based off of y)
          @blocks = Array.new( blockCount ) { Array.new }
          
          # Lists of block indices by type 
          @normal = Array.new
          @combos = Array.new
          @falling = Array.new
          @buffer = Array.new
          @swapping = Array.new
          
          @cursor = Cursor.new( self , @block_size )
     end     

     
     def addBlock( column )
          index = BlockFactory.generate( self , PL::NORMAL_COLORS.sample , column , @blocks[column].size )
          @blocks[column].push( index )
          @normal.push( index )
     end
     
     
     def bufferRow
          @blocks.each_index { |i|
               index = BlockFactory.generate( self , PL::NORMAL_COLORS.sample , i , 0 , PL::BUFFER )
               @blocks[i].insert( 0 , index )               
          }
     end
     
     
     def recalculatePosition
          @blocks.each_index { |column|
               @blocks[column].each_index { |row|
                    @blocks[column][row].relY += @@block_size
               }
          }
     end
     
     
     def checkSwap( timeElapsed )
          @timeSinceSwap += PL::millis - timeElapsed 
          
          if ( @timeSinceSwap >= PL::SWAP_TIME )
               block1 = ( @swapping[0].nil? ) ? nil : block( @swapping[0] )
               block2 = ( @swapping[1].nil? ) ? nil : block( @swapping[1] )
               
               
               if ( block1.nil? )
                    Physics::resetPhysics( block2 )
                    block2.col -= 1
                    
                    @blocks[block2.col][block2.row] = block2.index
                    @blocks[block2.col + 1][block2.col] = nil
                    
                    # TO-DO: Modify states of swapped blocks and blocks above them
                    # TO-DO: Check for combos
                    
                    block2.state = PL::NORMAL
               elsif ( block2.nil? )
                    Physics::resetPhysics( block1 )
                    block1.col += 1
                    
                    @blocks[block1.col][block1.row] = block1.index
                    @blocks[block1.col - 1][block1.col] = nil
                    
                    block1.state = PL::NORMAL
               else
                    Physics::resetPhysics( block1 , block2 )
                    block1.col += 1
                    block2.col -= 1
                    
                    @blocks[block1.col][block1.row] = block1.index
                    @blocks[block2.col][block2.row] = block2.index
                    
                    block1.state = PL::NORMAL
                    block2.state = PL::NORMAL
               end
               
               @swapping.clear
               @timeSinceSwap = 0
          end
     end
     
     
     def blockAbove( col , row )
          
     end
     
     
     def blockBelow( col , row )
          
     end
     
     
     def blockLeft( col , row )
          
     end
     
     
     def blockRight( col , row )
          
     end
     
         
     def findCombos
          
     end
     
     
     def draw( frame , timeElapsed )
          @riseV += @riseA * ( ( PL::millis - timeElapsed ) / 1000.0 )
          @offset += @riseV * ( ( PL::millis - timeElapsed ) / 1000.0 )
          @cursor.relY += @riseV * (  ( PL::millis - timeElapsed ) / 1000.0 )
                    
          if ( @offset >= @block_size ) 
               @offset = 0
               bufferRow
          end
          
          checkSwap( timeElapsed ) unless @swapping.empty?
          
          Physics::calculate( @swapping , timeElapsed )
          Physics::calculate( @falling , timeElapsed )
          
          findCombos
          drawFrame( frame , timeElapsed )
     end
     
     
     def drawFrame( frame , timeElapsed )
          frame.stroke( PL::colors[ "BLACK" ] )
                    
          @blocks.each_index { |column| 
               @blocks[column].each_index { |row| 
                    block( @blocks[column][row] ).draw( column , row , frame , timeElapsed ) unless @blocks[column][row].nil?
               }
          }
          
          @cursor.draw( frame , timeElapsed )
          
          frame.endDraw()
     end
     
     
     def block( i )
          BlockFactory.get( i )
     end
     
     
end
