=begin

     Maintains a list of Block objects, and a queue of available block indices.
     
     If a Board wants to create a Block, BlockFactory pops an index from 
     its available queue, modified the corresponding block according to
     parameters, and returns that index to the Board.

     "Deleting" a block involves resetting the attributes of the block, and pushing its
     index back on the available queue.     

=end


class BlockFactory
     
     
     @@blocks = nil
     @@available = nil
       
     
     
     def initialize
          @@blocks = Array.new( PL::RESERVED_BLOCKS )
          @@blocks.each_index do |i| 
               @@blocks[i] = Block.new
               @@blocks[i].index = i
          end
          @@available = (0..(PL::RESERVED_BLOCKS - 1)).to_a
     end
     
     
     def self.generate( parent , color , column , row , state = PL::NORMAL , type = PL::BLOCK_NORMAL )
          index = @@available.slice!( 0 )
          
          @@blocks[index].parent = parent
          @@blocks[index].state = state
          @@blocks[index].type = type
          @@blocks[index].color = color
          @@blocks[index].size = parent.block_size
          
          @@blocks[index].col = column
          @@blocks[index].row = row
          
          @@blocks[index].updateAbsolutePosition
          
          return index
     end
    
     
     def self.restore( index )
          @@available.push( index )
     end
     
     
     def self.get( i )
          @@blocks[i]
     end
     
end
