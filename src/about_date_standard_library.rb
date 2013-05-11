require File.expand_path(File.dirname(__FILE__) + '/neo')


class AboutDateStandardLibrary < Neo::Koan
  require 'date'

  def test_dates_are_objects_too
    date = Date.new
    assert_equal __(true), date.is_a?(Object)
  end

  def test_creating_dates_without_being_specific
    date_without_parameters = Date.new

    assert_equal __(true), date_without_parameters.year == -4712

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
    assert_equal __(2), string_date_with_dashes.month
    assert_equal __(24), string_date_with_dots.day

  end

  def test_dates_created_ordinally
    year = 1993
    days = 55
    ordinal_date = Date.ordinal(year, days)

    assert_equal __(24), ordinal_date.day
    assert_equal __(2), ordinal_date.month

  end

  def test_commercial_dates
    year = 1993
    week_of_year = 8
    day_of_week = 3
    commercial_date = Date.commercial(year, week_of_year, day_of_week)

    assert_equal __(24), commercial_date.day
    assert_equal __(2), commercial_date.month

  end

  def test_dates_are_immutable_changes_make_new_objects
    date = Date.new(1993, 2, 24)
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
    assert_equal __(2), weird_star_date.month
    assert_equal __(1993), wordy_date.year

  end

  def test_are_we_in_a_leap_year?
    not_a_leap_year = Date.new(1993,2,24).leap?
    leap_year = Date.new(1992,2,24).leap?

    assert_equal __(false), not_a_leap_year
    assert_equal __(true), leap_year

  end

  def test_what_is_the_weekday?
    date = Date.new(1993,2,24)
    days_as_words = Date::DAYNAMES

    assert_equal __(3), date.wday
    assert_equal __('Wednesday'), days_as_words[date.wday]
    assert_equal __('Wednesday'), date.strftime('%A')

  end

  def test_day_of_week_methods
    date = Date.new(1993,2,24)

    assert_equal __(false), date.monday?
    assert_equal __(false), date.tuesday?
    assert_equal __(true), date.wednesday?

  end

  def test_calendar_weeks_or_standard_weeks
    date = Date.new(1993,2,21)

    assert_equal __(0), date.wday
    assert_equal __(7), date.cwday
  end

  def test_adding_days
    date = Date.new(1993,2,24)
    date_plus_one = date + 1
    next_day = date.next_day
    more_than_one_day = date.next_day(4)

    assert_equal __(24), date.day
    assert_equal __(25), date_plus_one.day
    assert_equal __(25), next_day.day
    assert_equal __(28), more_than_one_day.day

  end

  def test_minus_subtracts_days
    date = Date.new(1993,2,24)
    date_minus_one = date -1
    previous_day = date.prev_day
    more_than_one_day_prior = date.prev_day(4)


    assert_equal __(24), date.day
    assert_equal __(23), date_minus_one.day
    assert_equal __(23), previous_day.day
    assert_equal __(20), more_than_one_day_prior.day


  end

  def test_what_is_the_month?
    date = Date.new(1993,2,24)

    assert_equal __(2), date.month
    assert_equal __(2), date.mon
    assert_equal __('February'), Date::MONTHNAMES[date.month]

  end


  def test_subtract_moths
    date = Date.new(1993,2,24)
    date_minus_month = date << 1
    previous_month = date.prev_month
    more_than_one_month_prior = date.prev_month(2)

    assert_equal __(2), date.month
    assert_equal __(1), date_minus_month.month
    assert_equal __(1), previous_month.month
    assert_equal __(12), more_than_one_month_prior.month

  end

  def test_adding_months
    date = Date.new(1993, 2,24)
    date_plus_month = date >> 1
    next_month = date.next_month
    more_than_one_month_in_the_future = date.next_month(2)

    assert_equal __(2), date.month
    assert_equal __(3), date_plus_month.month
    assert_equal __(3), next_month.month
    assert_equal __(4), more_than_one_month_in_the_future.month

  end

  def test_calendar_weeks
    date = Date.new(1993, 2,24)

    assert_equal __(8), date.cweek

  end

  def test_dates_can_be_enumerable
    date = Date.new(1993,2,24)
    date2 = date - 7
    date3 = date + 7

    assert_equal __(true), date.downto(date2).kind_of?(Enumerable)
    assert_equal __(true), date.upto(date3).kind_of?(Enumerable)
  end








end
