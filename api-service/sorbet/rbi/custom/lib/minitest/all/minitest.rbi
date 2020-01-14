# typed: strong

module Minitest
  class Mock

    sig do
      params(
        delegator: T.nilable(T.untyped)
      ).void
    end
    def initialize(delegator); end

    sig do
      params(
        name: Symbol,
        retval: BasicObject,
        args: T::Enumerable[T.untyped],
        blk: T.nilable(T.proc.void)
      ).returns(T.self_type)
    end
    def expect(name, retval, args = [], &blk); end

    sig do
      returns(TrueClass)
    end
    def verify; end
  end
end
