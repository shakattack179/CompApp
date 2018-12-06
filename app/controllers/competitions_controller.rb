class CompetitionsController < ApplicationController
  def index
    redirect_to new_competition_path
  end

  def new
  end

  def create
    workbook = Roo::Spreadsheet.open(params[:competitors], extension: :xlsx)
    sheet = workbook.sheet('Sheet1')
    @group_by_options = sheet.row(1)[1..-1]
    rows = []
    sheet.each_with_index do |hash, index|
      next if index == 0
      row = Hash.new
      sheet.row(1).each_with_index do |option, index|
        row[option] = hash[index]
      end
      rows << row
    end

    Rails.cache.write("rows", rows)
  end

  def finalize
    number_of_winners = params[:number_of_winners]
    group_winners_by = params[:group_winners_by]
    rows = Rails.cache.read("rows")
    @results = {}
    rows.group_by{|row| row[group_winners_by] }.map do |group, winners|
      @results[group] = winners.sample(number_of_winners.to_i)
    end
  end
end
