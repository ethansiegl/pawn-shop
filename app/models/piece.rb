require 'byebug'
class Piece < ActiveRecord::Base

	belongs_to :game

	def move_to!(x,y)
		destination_piece = piece_at(x,y)
		return false if friendly_piece?(destination_piece)

		if !destination_piece.present?
			update_coordinates(x,y)
		else
			capture!(destination_piece)
			update_coordinates(x,y)
		end
	end

  def obstructed_horizontally?(dest_x, dest_y)
    if dest_x > x_coordinate
      (x_coordinate + 1).upto(dest_x - 1) do |x|
        return true if horizontal_move?(x, dest_y) && space_occupied?(x, dest_y)
      end
    elsif dest_x < x_coordinate
      (x_coordinate - 1).downto(dest_x + 1) do |x|
        return true if horizontal_move?(x, y_coordinate) && space_occupied?(x, dest_y)
      end
    end
    false
  end

	def obstructed_vertically?(dest_x, dest_y)
    if dest_y > y_coordinate
      (y_coordinate + 1).upto(dest_y - 1) do |y|
        return true if vertical_move?(dest_x, y) && space_occupied?(dest_x, y)
      end
    elsif dest_y < y_coordinate
      (y_coordinate - 1).downto(dest_y + 1) do |y|
        return true if vertical_move?(dest_x, y) && space_occupied?(dest_x, y)
      end
    end
    false
  end

	def obstructed_diagonally?(dest_x, dest_y)
    if dest_x > x_coordinate && dest_y > y_coordinate
      (x_coordinate + 1).upto(dest_x - 1) do |x|
        (y_coordinate + 1).upto(dest_y - 1) do |y|
          return true if diagonal_move?(x, y) && space_occupied?(x, y)
        end
      end
    elsif dest_x > x_coordinate && dest_y < y_coordinate
      (x_coordinate + 1).upto(dest_x - 1) do |x|
        (y_coordinate - 1).downto(dest_y + 1) do |y|
          return true if diagonal_move?(x, y) && space_occupied?(x, y)
        end
      end
    elsif dest_x < x_coordinate && dest_y > y_coordinate
      (x_coordinate - 1).downto(dest_x + 1) do |x|
        (y_coordinate + 1).upto(dest_y - 1) do |y|
          return true if diagonal_move?(x, y) && space_occupied?(x, y)
        end
      end
    elsif dest_x < x_coordinate && dest_y < y_coordinate
      (x_coordinate - 1).downto(dest_x + 1) do |x|
        (x_coordinate - 1).downto(dest_y + 1) do |y|
          return true if diagonal_move?(x, y) && space_occupied?(x, y)
        end
      end
    end
    false
  end

	def space_occupied?(x, y)
		game.pieces.where(x_coordinate: x, y_coordinate: y).take.present?
	end

	def piece_at(x, y)
		game.pieces.where(x_coordinate: x, y_coordinate: y).take
	end

	def capture!(target_piece)
		target_piece.update(taken: true, x_coordinate: nil, y_coordinate: nil)
	end

  def update_coordinates(x,y)
		update(x_coordinate: x, y_coordinate: y)
	end

	def friendly_piece?(piece)
		return true if piece.present? && color == piece.color
	end

  def off_board?(x, y)
  	(x > 8 || y > 8 || x < 1 || y < 1) ? true : false
	end

	def no_move?(x, y)
 		(x == x_coordinate) && (y == y_coordinate) ? true : false
 	end

 	def horizontal_move?(x, y)
 		(x != x_coordinate) && (y == y_coordinate) ? true : false
 	end

 	def vertical_move?(x, y)
 		(x == x_coordinate) && (y != y_coordinate) ? true : false
 	end

 	def diagonal_move?(x, y)
 		(x - x_coordinate).abs == (y - y_coordinate).abs ? true : false
 	end

 	def is_white?(piece)
 		piece.color == "white" ? true : false
 	end

 	def puts_in_check?(x,y)
		if color == "white"
			opposite_color = "black"
		elsif color == "black"
			opposite_color = "white"
		end

		opponents = game.pieces.where(color: opposite_color)
		opponents.each do |piece|
			return true if piece.valid_move?(x,y)
		end
	end
end
