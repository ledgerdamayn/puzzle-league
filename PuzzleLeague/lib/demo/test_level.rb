# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class TestLevel < Level
     
     def initialize
          super( "Test Level" , 6 , ( 1.0 - PL::BOARD_WIDTH_PERCENT ) / 2.0 ,
                                    ( 1.0 - PL::BOARD_HEIGHT_PERCENT ) / 2.0 )
           
          addBlock( 3 )
          addBlock( 3 )
          addBlock( 1 )
          bufferRow
     end
     
     
end
