=begin

     Blocks are the smallest unit of the game.
     
     They are not directly instantiated; they are modified by reference using the
     BlockFactory class.

     Blocks are positioned relative to their parent Board object.

=end


class Block
     
     
     attr_accessor :absX , :absY , # Absolute position (origin at top-left)
                   :relX , :relY , # Relative position (origin at bottom-left)
                   :v_x , :v_y , :a_x , :a_y ,
                   :col , :row ,
                   :type , :color , :parent , :index , :state , :size
                 
     
     def initialize( index = 0 )
          @index = index
          reset
     end
     
     
     def draw( x , y , frame , timeElapsed )
          frame.fill( PL::colors[ @color ] )
          
          p @state
          case @state
          when PL::NORMAL , PL::BUFFER
               frame.rect( x * @size , 
                      @parent.height - ( y * @size + @parent.offset ) , 
                      @size , @size , PL::BLOCK_ROUNDING )
          when PL::SWAPPING
               frame.rect( @relX , @parent.height - @relY ,
                      @size , @size , PL::BLOCK_ROUNDING )
          end
          
          
     end
    
     
     def reset
          @parent = nil
          @state = PL::INACTIVE
          @absX = 0 ; @absY = 0
          @relX = 0 ; @relY = 0
          @col = 0 ; @row = 0
          @type = PL::BLOCK_NORMAL
          @size = 0
          
          @v_x = 0 ; @v_y = 0
          @a_x = 0 ; @a_y = 0
     end
     
     
     def updateAbsolutePosition
          @absX = @parent.x + @relX
          @absY = @parent.y + ( @parent.height - @relY ) + @parent.offset
     end
     
     
     def localize
          @relX = @col * @size
          @relY = @row * @size + @parent.offset
     end
     
     
     def restore
          reset
          BlockFactory.restore( index )
     end

end
