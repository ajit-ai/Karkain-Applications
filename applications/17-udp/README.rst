17-udp — A15 UDP (blocked)
============================

No implementation. Karkain 1.1.0 provides no UDP/datagram builtins
(no ``net_udp_*`` socket family, no datagram error model), confirmed
by source scan. This directory holds documentation only, per the
laboratory rule: a documented blocker is a successful result.

Gap: CAP-001. Do not implement UDP here until the runtime provides
datagram primitives.
