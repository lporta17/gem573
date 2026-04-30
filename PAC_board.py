from gem5.components.boards.simple_board import SimpleBoard
from gem5.components.cachehierarchies.classic.no_cache import NoCache
from gem5.components.memory.single_channel import SingleChannelDDR3_1600
from gem5.components.processors.cpu_types import CPUTypes
from gem5.components.processors.simple_processor import SimpleProcessor
from gem5.isas import ISA
from gem5.resources.resource import BinaryResource
from gem5.simulate.simulator import Simulator

# 1. Setup Processor (Using Timing so we can see cycle progress)
processor = SimpleProcessor(
    cpu_type=CPUTypes.TIMING, isa=ISA.RISCV, num_cores=1
)

# 2. Setup Memory and a basic "No Cache" hierarchy (Required by SimpleBoard)
memory = SingleChannelDDR3_1600(size="2GB")
cache_hierarchy = NoCache()

# 3. Instantiate the Board
board = SimpleBoard(
    clk_freq="1.2GHz",
    processor=processor,
    memory=memory,
    cache_hierarchy=cache_hierarchy,
)

# 4. Point to your compiled binary
board.set_se_binary_workload(
    BinaryResource(local_path="tests/test-progs/quicksort_riscv")
)

# 5. Run it
simulator = Simulator(board=board)
print("Beginning simulation!")
simulator.run()
print(
    "Exiting @ tick {} because {}.".format(
        simulator.get_current_tick(), simulator.get_last_exit_event_cause()
    )
)