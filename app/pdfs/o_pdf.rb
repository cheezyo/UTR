class OPdf < Prawn::Document
  def initialize(players, view)
    super(top_margin: 70)
    @players = players
    @view = view
    order_number
    #line_items
    mk_table
    
  end
  
  def order_number
    text "UTR Januar 2020", size: 30, style: :bold
  end
  
  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

def mk_table 
 data = [["This row should be repeated on every new page"]]
data += [["..."]] * 30
pdf.table(data, :header => true)

end

  def line_item_rows

    num = 1
    [["Rank", "Navn", "Fødselsår", "Utr", "Reliability"]] +
   
    @players.each do |item|

      [num, item.name, item.birthyear, item.utr, item.reliability]
      num = num + 1 
    end
  end
  
 

end