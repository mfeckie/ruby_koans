require File.expand_path(File.dirname(__FILE__) + '/neo')


class AboutDateStandardLibrary < Neo::Koan
  require 'date'

  RUBY_BIRTHDAY = Date.new(1993, 2, 24)

  def test_when_was_RUBY_born

    assert_equal __(1993), RUBY_BIRTHDAY.year
    assert_equal __(2), RUBY_BIRTHDAY.month
    assert_equal __(24), RUBY_BIRTHDAY.day


  end

  def test_dates_are_objects_too
    date = Date.new
    assert_equal __(true), date.is_a?(Object)
  end

  def test_creating_dates_without_being_specific
    date_without_parameters = Date.new

    assert_equal __(true), date_without_parameters.year == -4712
    assert_equal __(true), date_without_parameters.month == 1
    assert_equal __(true), date_without_parameters.day == 1

  end

  def test_dates_follow_US_format_by_default
    date_with_parameters = Date.new(1993, 2, 24)

    assert_equal __(1993), date_with_parameters.year
    assert_equal __(2), date_with_parameters.month
    assert_equal __(24), date_with_parameters.day

  end

  def test_we_can_create_a_date_for_today
    today = Date.today

    assert_equal __(true), today.is_a?(Date)

  end

  def test_dates_can_be_created_from_strings
    string_date_with_slashes = Date.parse('1993/2/24')
    string_date_with_dashes = Date.parse('1993-2-24')
    string_date_with_dots = Date.parse('1993.2.24')


    assert_equal __(1993), string_date_with_slashes.year
    assert_equal __(2), string_date_with_slashes.month
    assert_equal __(24), string_date_with_slashes.day

    assert_equal __(1993), string_date_with_dashes.year
    assert_equal __(2), string_date_with_dashes.month
    assert_equal __(24), string_date_with_dashes.day

    assert_equal __(1993), string_date_with_dots.year
    assert_equal __(2), string_date_with_dots.month
    assert_equal __(24), string_date_with_dots.day

  end

  def test_dates_created_ordinally
    year = 1993
    days = 55
    ordinal_date = Date.ordinal(year, days)

    assert_equal __(24), ordinal_date.day
    assert_equal __(2), ordinal_date.month
    assert_equal __(1993), ordinal_date.year

  end

  def test_commercial_dates
    year = 1993
    week_of_year = 8
    day_of_week = 3
    commercial_date = Date.commercial(year, week_of_year, day_of_week)

    assert_equal __(1993), commercial_date.year
    assert_equal __(2), commercial_date.month
    assert_equal __(24), commercial_date.day


  end

  def test_dates_are_immutable_changes_make_new_objects
    date = RUBY_BIRTHDAY
    date_object_id = date.object_id
    date += 1
    date_object_id2 = date.object_id

    assert_equal __(false), date_object_id == date_object_id2

  end

  def test_dates_from_complex_string_formats
    uk_date = Date.strptime('24/2/1993', '%d/%m/%Y')
    weird_star_date = Date.strptime('1993*2*24', '%Y*%m*%d')
    wordy_date = Date.strptime('Wednesday February 24th 1993', '%A %B %dth %Y')

    assert_equal __(24), uk_date.day
    assert_equal __(2), uk_date.month
    assert_equal __(1993), uk_date.year

    assert_equal __(1993), weird_star_date.year
    assert_equal __(2), weird_star_date.month
    assert_equal __(24), weird_star_date.day


    assert_equal __(1993), wordy_date.year
    assert_equal __(2), wordy_date.month
    assert_equal __(24), wordy_date.day


  end

  def test_are_we_in_a_leap_year?
    not_a_leap_year = RUBY_BIRTHDAY
    leap_year = Date.new(1992, 2, 24)

    assert_equal __(false), not_a_leap_year.leap?
    assert_equal __(true), leap_year.leap?

  end

  def test_what_is_the_weekday?
    date = RUBY_BIRTHDAY
    days_as_words = Date::DAYNAMES

    assert_equal __(3), date.wday
    assert_equal __('Wednesday'), days_as_words[date.wday]
    assert_equal __('Wednesday'), date.strftime('%A')

  end

  def test_day_of_week_methods
    date = RUBY_BIRTHDAY

    assert_equal __(false), date.monday?
    assert_equal __(false), date.tuesday?
    assert_equal __(true), date.wednesday?
    assert_equal __(false), date.thursday?
    assert_equal __(false), date.friday?
    assert_equal __(false), date.saturday?
    assert_equal __(false), date.sunday?

  end

  def test_calendar_weeks_or_standard_weeks
    date = Date.new(1993, 2, 21)

    assert_equal __(0), date.wday
    assert_equal __(7), date.cwday
  end

  def test_adding_days
    date = RUBY_BIRTHDAY
    date_plus_one = date + 1
    next_day = date.next_day
    more_than_one_day = date.next_day(4)

    assert_equal __(24), date.day
    assert_equal __(25), date_plus_one.day
    assert_equal __(25), next_day.day
    assert_equal __(28), more_than_one_day.day

  end

  def test_subtracting_days
    date = RUBY_BIRTHDAY
    date_minus_one = date - 1
    previous_day = date.prev_day
    more_than_one_day_prior = date.prev_day(4)


    assert_equal __(24), date.day
    assert_equal __(23), date_minus_one.day
    assert_equal __(23), previous_day.day
    assert_equal __(20), more_than_one_day_prior.day


  end

  def test_what_is_the_month
    date = RUBY_BIRTHDAY

    assert_equal __(2), date.month
    assert_equal __(2), date.mon
    assert_equal __('February'), Date::MONTHNAMES[date.month]

  end


  def test_subtracting_months
    date = RUBY_BIRTHDAY
    date_minus_month = date << 1
    previous_month = date.prev_month
    more_than_one_month_prior = date.prev_month(2)

    assert_equal __(2), date.month
    assert_equal __(1), date_minus_month.month
    assert_equal __(1), previous_month.month
    assert_equal __(12), more_than_one_month_prior.month
    assert_equal __(1992), more_than_one_month_prior.year


  end

  def test_adding_months
    date = RUBY_BIRTHDAY
    date_plus_month = date >> 1
    next_month = date.next_month
    more_than_one_month_in_the_future = date.next_month(2)

    assert_equal __(2), date.month
    assert_equal __(3), date_plus_month.month
    assert_equal __(3), next_month.month
    assert_equal __(4), more_than_one_month_in_the_future.month

  end

  def test_what_is_the_year?
    date = RUBY_BIRTHDAY

    assert_equal __(1993), date.year
  end

  def test_adding_years
    date = RUBY_BIRTHDAY
    next_year = date.next_year
    more_than_one_year_later = date.next_year(10)

    assert_equal __(1994), next_year.year
    assert_equal __(2003), more_than_one_year_later.year

  end

  def test_subtracting_years
    date = RUBY_BIRTHDAY
    previous_year = date.prev_year
    more_than_one_year_prior = date.prev_year(10)

    assert_equal __(1992), previous_year.year
    assert_equal __(1983), more_than_one_year_prior.year
  end

  def test_calendar_weeks
    date = RUBY_BIRTHDAY

    assert_equal __(8), date.cweek

  end

  def test_dates_can_be_enumerable
    date = RUBY_BIRTHDAY
    date2 = date - 7
    date3 = date + 7

    assert_equal __(true), date.downto(date2).kind_of?(Enumerable)
    assert_equal __(true), date.upto(date3).kind_of?(Enumerable)

  end

  def test_is_a_date_between?
    start_date = RUBY_BIRTHDAY
    end_date = Date.new(1994, 2, 24)
    date1 = Date.new(1993, 6, 1)
    date2 = Date.new(1994, 2, 25)

    assert_equal __(true), date1.between?(start_date, end_date)
    assert_equal __(false), date2.between?(start_date, end_date)

  end

  def test_date_as_a_string
    date = RUBY_BIRTHDAY

    assert_equal __('1993-02-24'), date.to_s

  end


end
