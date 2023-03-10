# frozen_string_literal: true

class Battle < TestBot::Message
  def run
    p_args = parse_args(/^\s*냥\s+배틀\s*/)

    arg = p_args.first
    unless arg.present?
      puts '스스로와의 싸움.. 멋져요 화이팅!:meow_wow:'
      return
    end

    winner, loser = [user.name, arg].shuffle
    puts format(MESSAGE.sample, winner: "#{winner}님", loser: "#{loser}님")
  end

  MESSAGE = [
    '*%<loser>s* 독화살을 맞고 사경을 헤매네요.. 승자는 *%<winner>s*!',
    '*%<loser>s* 발을 헛딛고 넘어졌어요! 승자는 *%<winner>s*!',
    '*%<loser>s* 절벽에서 떨어졌어요! 승자는 *%<winner>s*!',
    '*%<loser>s* 강물에 빠져 휩쓸려가네요! 승자는 *%<winner>s*!',
    '*%<loser>s* 돌멩이에 맞고 쓰러졌어요! 승자는 *%<winner>s*!',
    '*%<loser>s* 트랩을 밟아버렸어요! 승자는 *%<winner>s*!',
    '*%<loser>s* 멍때리다 당했네요! 승자는 *%<winner>s*!',
    '*%<loser>s* 낙엽 소리에 심장마비! 승자는 *%<winner>s*!',
    '*%<loser>s* 에게 파괴광선! 효과는 굉장했다! 승자는 *%<winner>s*!',
    '*%<loser>s* 에게 하이드로펌프! 급소에 맞았다! 승자는 *%<winner>s*!',

    # 패배!
    '*%<winner>s* 전략적으로 멍때리는 척하다 반격했어요! *%<loser>s* 패배!',
    '*%<winner>s* 날아온 돌멩이를 캐치해 반격에 성공! *%<loser>s* 패배!',
    '*%<winner>s* 독화살을 아슬아슬하게 피하고 반격했어요! *%<loser>s* 패배!',
    '*%<winner>s* 각성하니 무시무시하네요! *%<loser>s* 패배!',
    '*%<winner>s* 에게 몸통박치기! 빗나갔다! *%<loser>s* 패배!'
  ].freeze
end
