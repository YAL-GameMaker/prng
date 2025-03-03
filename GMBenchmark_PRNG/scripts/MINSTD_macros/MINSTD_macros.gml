#macro m_minstd_start var minstd_state = 
#macro m_minstd_next minstd_state = (minstd_state * 48271) % 2147483647
#macro m_minstd_value (minstd_state / 2147483647)
#macro m_minstd_float m_minstd_value *
#macro m_minstd_var minstd_state
