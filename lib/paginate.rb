class PageButton
  attr_accessor :html_class, :page, :text

  # def initialize(html_class = '', page = '', text = '')
  #   @html_class = html_class
  #   @page = page
  #   @text = text
  # end
end

class Paginate
  @@rows_on_page = 3
  @@books_on_row = 3

  @@books_on_page = @@rows_on_page * @@books_on_row

  cattr_reader :rows_on_page, :books_on_row, :books_on_page

  attr_reader :first_btn, :prev_btn, :page_btns, :next_btn, :last_btn

  def parse_books(books)
    rows = []
    @@rows_on_page.times do |i|
      break if (i*@@books_on_row)+1 > books.size

      row_books = []
      @@books_on_row.times do |y|
        idx = i*@@books_on_row + y
        break if idx+1 > books.size

        row_books << books[idx]
      end
      rows << row_books
    end
    rows
  end

  def set_buttons(current_page, all_elements_count)
    pages_count = all_elements_count / Paginate.books_on_page
    pages_count += 1 if (all_elements_count % Paginate.books_on_page) > 0

    pages_links = 5
    page_idx = current_page - 1
    start_page_idx = page_idx - (page_idx % pages_links)
    start_page = start_page_idx + 1
    end_page = start_page_idx + pages_links
    if end_page < current_page
      end_page = current_page
    end

    @first_btn = PageButton.new
    @first_btn.text = '<<'
    if current_page <= pages_links*2
      @first_btn.html_class = 'disabled'
    else
      @first_btn.page = '1'
    end

    @prev_btn = PageButton.new
    @prev_btn.text = '<'
    if current_page <= pages_links
      @prev_btn.html_class = 'disabled'
    else
      @prev_btn.page = (start_page - pages_links).to_s
    end

    if pages_count >= pages_links
      begin_idx = start_page
      end_idx = end_page
      if end_idx > pages_count
        end_idx = pages_count
      end
    else
      begin_idx = 1
      end_idx = pages_count
    end

    @page_btns = []
    for i in begin_idx .. end_idx
      curr_btn = PageButton.new
      curr_btn.text = i.to_s
      if i == current_page
        curr_btn.html_class = 'active'
      else
        curr_btn.page = i.to_s
      end

      @page_btns << curr_btn
    end

    @next_btn = PageButton.new
    @next_btn.text = '>'
    if end_page >= pages_count
      @next_btn.html_class = 'disabled'
    else
      @next_btn.page = (end_idx + 1).to_s
    end

    @last_btn = PageButton.new
    @last_btn.text = '>>'
    if end_page >= pages_count - pages_links
      @last_btn.html_class = 'disabled'
    else
      @last_btn.page = pages_count.to_s
    end

  end

end
