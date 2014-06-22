# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Physics
     
     def self.calculate( blocks , timeElapsed )
          blocks.each do |b|
               blocks.v_x += blocks.a_x * ( ( PL::millis - timeElapsed ) / 1000.0 )
               blocks.relX += blocks.v_x * ( ( PL::millis - timeElapsed ) / 1000.0 )
               
               blocks.v_y += blocks.a_y * ( ( PL::millis - timeElapsed ) / 1000.0 )
               blocks.relY += blocks.v_y * ( ( PL::millis - timeElapsed ) / 1000.0 )
          end
     end
     
     
     def self.resetPhysics( blocks )
          blocks.each do |b|
               b.relX = 0
               b.v_x = 0
               b.a_x = 0
               b.relY = 0
               b.v_y = 0
               b.a_y = 0
          end
     end
     
end
