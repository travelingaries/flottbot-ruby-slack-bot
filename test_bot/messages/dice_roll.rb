# frozen_string_literal: true

class DiceRoll < TestBot::Message
  def run
    puts "#{user_name}, #{message(rand(1..100))}"
  end

  def user_name
    args[0]
  end

  def message(number)
    group =
      if number >= 81
        %i[amazing tada]
      elsif number >= 71
        %i[throw no_feeling amazing]
      elsif number >= 41
        %i[throw no_feeling]
      elsif number >= 31
        %i[unlucky throw no_feeling]
      elsif number >= 16
        %i[mang unlucky no_feeling]
      else
        [:mang]
      end
    format(MSG[group.sample].sample, number: number)
  end

  MSG = {
    amazing: [
      '대단해요! %<number>s 나왔어요 :meow_wow:',
      '정말 대단해요! %<number>s 나왔어요 :meow_wow:',
      '와 대단해요! %<number>s 나왔어요 :meow_wow:'
    ],
    unlucky: [
      '앗 아쉽네요.. %<number>s 나왔어요...:meow-fine:',
      '오늘 운이 좋지 않네요.. %<number>s 나왔어요...:meow-fine:',
      '%<number>s 나왔어요... 담엔 더 높게 나올 거에요 :meow-fine:'
    ],
    throw: [
      '온 힘을 다해 주사위를 굴렸는데.. %<number>s 나왔어요',
      '우주의 기운을 모아 주사위를 굴렸는데.. %<number>s 나왔어요',
      '커피 수혈한 힘으로 주사위를 굴렸는데.. %<number>s 나왔어요'
    ],
    mang: [
      '완전 :mang:이네요.. 주사위가 %<number>s 나왔어요... :우는냥:',
      '정말 :mang:이네요.. 주사위가 %<number>s 나왔어요... :우는냥:',
      ':mang:이네요.. 주사위가 %<number>s 나왔어요... :우는냥:',
      '이런 :mang:이네요.. 주사위가 %<number>s 나왔어요... :우는냥:'
    ],
    no_feeling: [
      '별 의욕 없이 주사위를 굴렸는데.. %<number>s 나왔어요...',
      '별 의지 없이 주사위를 굴렸는데.. %<number>s 나왔어요...'
    ],
    tada: [
      '와 축하해요! 무려 %<number>s 나왔네요~ :meow_party:',
      '대박! %<number>s 나왔네요~ :meow_party:',
      '엄청나네요! %<number>s 나왔어요~ :meow_party:'
    ]
  }.freeze
end
