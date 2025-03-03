#macro m_xorshift64_start var xorshift64_state = int64
#macro m_xorshift64_next { \
	xorshift64_state ^= (xorshift64_state << 13);\
	xorshift64_state ^= (((xorshift64_state & $7fffffffffffffff) >> 7) | ((xorshift64_state < 0) * $100000000000000));\
	xorshift64_state ^= (xorshift64_state << 17);\
}
#macro m_xorshift64_value ((xorshift64_state & $1FFFFFFFFFFFFF) / 9007199254740992.0)
#macro m_xorshift64_float m_xorshift64_value *
#macro m_xorshift64_var xorshift64_state
