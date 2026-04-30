from gem5.components.boards.simple_board import SimpleBoard
from gem5.components.cachehierarchies.classic.no_cache import NoCache
from gem5.components.memory.single_channel import SingleChannelDDR3_1600
from gem5.isas import ISA
from gem5.resources.resource import BinaryResource
from gem5.simulate.simulator import Simulator

from gem5.components.processors.base_cpu_core import BaseCPUCore
from gem5.components.processors.base_cpu_processor import BaseCPUProcessor

from m5.objects import RiscvO3CPU
from m5.objects import TournamentBP
from m5.objects import BranchPredictor

# 1. Setup Processor (Using Timing so we can see cycle progress)
class MyOutOfOrderCore(BaseCPUCore):
    def __init__(self, width, rob_size, num_int_regs, num_fp_regs):
        super().__init__(RiscvO3CPU(), ISA.RISCV)
        self.core.fetchWidth = width
        self.core.decodeWidth = width
        self.core.renameWidth = width
        self.core.issueWidth = width
        self.core.wbWidth = width
        self.core.commitWidth = width

        self.core.numROBEntries = rob_size

        self.core.numPhysIntRegs = num_int_regs
        self.core.numPhysFloatRegs = num_fp_regs

        self.core.branchPred = BranchPredictor(conditionalBranchPred=TournamentBP())

        self.core.LQEntries = 128
        self.core.SQEntries = 128

class MyOutOfOrderProcessor(BaseCPUProcessor):
    def __init__(self, width, rob_size, num_int_regs, num_fp_regs):
        cores = [MyOutOfOrderCore(width, rob_size, num_int_regs, num_fp_regs)]
        super().__init__(cores)

processor = MyOutOfOrderProcessor(width=8, rob_size=192, num_int_regs=256, num_fp_regs=256)

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
    BinaryResource(local_path="tests/test-progs/delaytest_riscv")
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
