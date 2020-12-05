defmodule AtbashTest do
  use ExUnit.Case

  describe "encode" do
    test "yes" do
      assert Atbash.encode("yes") == "bvh"
    end

    test "no" do
      assert Atbash.encode("no") == "ml"
    end

    test "OMG" do
      assert Atbash.encode("OMG") == "lnt"
    end

    test "O M G" do
      assert Atbash.encode("O M G") == "lnt"
    end

    test "mindblowingly" do
      assert Atbash.encode("mindblowingly") == "nrmwy oldrm tob"
    end

    test "numbers" do
      assert Atbash.encode("Testing, 1 2 3, testing.") == "gvhgr mt123 gvhgr mt"
    end

    test "deep thought" do
      assert Atbash.encode("Truth is fiction.") == "gifgs rhurx grlm"
    end

    test "all the letters" do
      plaintext = "The quick brown fox jumps over the lazy dog."
      cipher = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
      assert Atbash.encode(plaintext) == cipher
    end
  end

  describe "decode" do
    test "exercism" do
      cipher = "vcvix rhn"
      plaintext = "exercism"
      assert Atbash.decode(cipher) == plaintext
    end

    test "a sentence" do
      cipher = "zmlyh gzxov rhlug vmzhg vkkrm thglm v"
      plaintext = "anobstacleisoftenasteppingstone"
      assert Atbash.decode(cipher) == plaintext
    end

    test "numbers" do
      cipher = "gvhgr mt123 gvhgr mt"
      plaintext = "testing123testing"
      assert Atbash.decode(cipher) == plaintext
    end

    test "all the letters" do
      cipher = "gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt"
      plaintext = "thequickbrownfoxjumpsoverthelazydog"
      assert Atbash.decode(cipher) == plaintext
    end

    test "with too many spaces" do
      cipher = "vc vix    r hn"
      plaintext = "exercism"
      assert Atbash.decode(cipher) == plaintext
    end

    test "with no spaces" do
      cipher = "zmlyhgzxovrhlugvmzhgvkkrmthglmv"
      plaintext = "anobstacleisoftenasteppingstone"
      assert Atbash.decode(cipher) == plaintext
    end
  end
end
