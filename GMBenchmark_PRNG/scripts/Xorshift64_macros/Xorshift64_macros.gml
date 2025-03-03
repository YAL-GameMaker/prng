#macro m_xorshift_start var xorshift_state = int64
#macro m_xorshift_next { \
	xorshift_state ^= (xorshift_state << 13);\
	xorshift_state ^= (((xorshift_state & $7fffffffffffffff) >> 7) | ((xorshift_state < 0) * $100000000000000));\
	xorshift_state ^= (xorshift_state << 17);\
}
#macro m_xorshift_value ((xorshift_state & $1FFFFFFFFFFFFF) / 9007199254740992.0)
#macro m_xorshift_float m_xorshift_value *
#macro m_xorshift_var xorshift_state
