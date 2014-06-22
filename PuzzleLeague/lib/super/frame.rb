=begin

     Frame objects represent functional components of a Scene.
     
     Frames maintain absolute position and size information,
     derived from percentages.  Objects within the frame use the frame's
     bottom-left corner as an origin.

     Frames are rendered offscreen as PGraphics.

=end


class Frame
     
     
     attr_accessor :x , :y , :width , :height , :label ,
                   :widthPercent , :heightPercent , :xOffsetPercent , :yOffsetPercent ,
                   :background_color ,
                   :frame # PGraphics object
              
     
     
     def initialize( label , widthPercent , heightPercent , xOffsetPercent , yOffsetPercent , background_color = PL::DEFAULT_FRAME_BACKGROUND )
          @label = label
          
          @widthPercent = widthPercent
          @heightPercent = heightPercent
          @xOffsetPercent = xOffsetPercent
          @yOffsetPercent = yOffsetPercent
          
          @background_color = background_color
          
          updatePosition
          
          @frame = PL::sketch.createGraphics( @width , @height )
     end
     
     
     # Either on initialization or on screen size change
     def updatePosition
          @x = PL::sketch.width * @xOffsetPercent
          @y = PL::sketch.height * @yOffsetPercent
          @width = PL::sketch.width * @widthPercent
          @height = PL::sketch.height * @heightPercent
     end
     
     
     # Default behavior
     def draw( timeElapsed )
          PL::sketch.image( @frame , @x , @y )
     end
     
     
     def handleInput( key , keyCode )
          
     end     
     
     
end
