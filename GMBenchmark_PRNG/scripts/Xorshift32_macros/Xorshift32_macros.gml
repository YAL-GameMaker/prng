#macro m_xorshift32_start var xorshift32_state = int64
#macro m_xorshift32_next { \
	xorshift32_state ^= (xorshift32_state << 13) & $FFFFFFFF;\
	xorshift32_state ^= (xorshift32_state >> 17);\
	xorshift32_state ^= (xorshift32_state << 5) & $FFFFFFFF;\
}
#macro m_xorshift32_value ((xorshift32_state) / 4294967296.0)
#macro m_xorshift32_float m_xorshift32_value *
#macro m_xorshift32_var xorshift32_state
