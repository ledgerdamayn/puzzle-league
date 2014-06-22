=begin

     Scenes represent different game views, such as game modes, or menus.

     Scenes are containers for Frame objects, which represent groups of visible
     elements, such as a board, or sub-menu.

=end


class Scene
   
     
     attr_accessor :frames , :background_color
     
     
     def initialize( background_color = PL::DEFAULT_BACKGROUND , frames = nil )
          @background_color = background_color
          @frames = Hash.new
          
          if ( !frames.nil? )
               frames.each do |f| @frames[ f.label ] = f end
          end 
     end
     
     
     def addFrame( frame )
          p @frames[ frame.label ] = frame
     end
     
     
     def draw( timeElapsed )
          PL::sketch.background( PL::colors[ @background_color ] )
          
          @frames.values.each do |f| 
               f.draw( timeElapsed )
          end
     end
         
     
     def handleInput( key , keyCode )
          @frames.values.each do |f| f.handleInput( key , keyCode ) end
     end
     
end
