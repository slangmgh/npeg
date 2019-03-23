import unittest
import npeg
import json
  
{.push warning[Spacing]: off.}


suite "npeg":

  test "atoms":
    doAssert     patt(0 * "a")("a").ok
    doAssert     patt(1)("a").ok
    doAssert     patt(1)("a").ok
    doAssert not patt(2)("a").ok
    doAssert     patt("a")("a").ok
    doAssert not patt("a")("b").ok
    doAssert     patt("abc")("abc").ok
    doAssert     patt({'a'})("a").ok
    doAssert not patt({'a'})("b").ok
    doAssert     patt({'a','b'})("a").ok
    doAssert     patt({'a','b'})("b").ok
    doAssert not patt({'a','b'})("c").ok
    doAssert     patt({'a'..'c'})("a").ok
    doAssert     patt({'a'..'c'})("b").ok
    doAssert     patt({'a'..'c'})("c").ok
    doAssert not patt({'a'..'c'})("d").ok
    doAssert     patt({'a'..'c'})("a").ok

  test "not":
    doAssert     patt('a' * !'b')("ac").ok
    doAssert not patt('a' * !'b')("ab").ok

  test "count":
    doAssert     patt(1{3})("aaaa").ok
    doAssert     patt(1{4})("aaaa").ok
    doAssert not patt('a'{5})("aaaa").ok
    doAssert not patt('a'{2..4})("a").ok
    doAssert     patt('a'{2..4})("aa").ok
    doAssert     patt('a'{2..4})("aaa").ok
    doAssert     patt('a'{2..4})("aaaa").ok
    doAssert     patt('a'{2..4})("aaaaa").ok
    doAssert     patt('a'{2..4})("aaaab").ok

  test "repeat":
    doAssert     patt(*'a')("aaaa").ok
    doAssert     patt(*'a' * 'b')("aaaab").ok
    doAssert     patt(*'a' * 'b')("bbbbb").ok
    doAssert not patt(*'a' * 'b')("caaab").ok
    doAssert     patt(+'a' * 'b')("aaaab").ok
    doAssert     patt(+'a' * 'b')("ab").ok
    doAssert not patt(+'a' * 'b')("b").ok

  test "choice":
    doAssert     patt("ab" | "cd")("ab").ok
    doAssert     patt("ab" | "cd")("cd").ok
    doAssert not patt("ab" | "cd")("ef").ok


