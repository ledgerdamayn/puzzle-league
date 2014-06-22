# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class TestScene < Scene
     
     
     def initialize
          super( PL::DEFAULT_BACKGROUND , [ TestLevel.new ] )
     end
     
     
end
