module sui_system::supper_committee{

    use std::type_name;
    use std::ascii::String;
    use sui::event;
    use sui::bag::{Self,Bag};
    use sui::clock::Clock;
    use sui::address;
    use sui::vec_set::{Self,VecSet};
    use sui::vec_map::VecMap;
    use sui::dynamic_field as df;

    use sui_system::voting_power;

    const Timeout:u64 = 7 * 24 * 60 * 60 * 1000;


    public struct ActionKey has store,copy,drop {}


    /// proposal status 
    const PROPOSAl_STATUS_PENDING: u8 = 1;
    const PROPOSAl_STATUS_ACTIVE:u8 = 2;
    const PROPOSAl_STATUS_PASS:u8 = 3;
    const PROPOSAl_STATUS_FAIL:u8 = 4;
    const PROPOSAl_STATUS_TIMEOUT:u8 = 5;


    public struct SupperCommittee has store {
        proposal_list: vector<ID>,
        /// Any extra fields that's not defined statically.
        extra_fields: Bag,
    }

    public struct Proposal has key{
        id: UID,
        /// creator of the proposal
        proposer: address,
        /// count of voters who agree with the proposal
        for_votes: VecSet<address>,
        /// count of voters who're against the proposal
        against_votes: VecSet<address>,
        start_time_ms: u64,
        end_time_ms: u64,
        action_type:String,
        status: u8,
    }

    // Errors
    const ENotProposalStatusProgress:u64 = 1;
    const ENotSupportStructType:u64 = 2;


    public struct CreateProposalEvent has copy,drop {
        proposal_id: ID,
        proposer: address, 
        action_type: String
    }

    public struct VoteProposalEvent has copy,drop {
        proposal_id: ID,
        voter: address,
        agree: bool,
        status: u8,
    }



    public(package) fun new(
        ctx: &mut TxContext,
    ):SupperCommittee{
        SupperCommittee{
            proposal_list:vector::empty(),
            extra_fields :bag::new(ctx)
        }
    }


    public(package) fun vote_proposal(
        proposal: &mut Proposal,
        validator_vote_powers: VecMap<address,u64>,
        validator_address: address,
        agree: bool,
        clock: &Clock,
        ctx: &TxContext,
    ){
        let sender = ctx.sender();

        assert!(proposal.proposal_status(clock) == PROPOSAl_STATUS_ACTIVE,ENotProposalStatusProgress);

        if(agree){
            proposal.for_votes.insert(validator_address);
        }else {
            proposal.against_votes.insert(validator_address);
        };

        let (for_vote_power,against_vote_power)  = proposal.get_vote_power(validator_vote_powers);
       
        if(for_vote_power >= voting_power::quorum_threshold()){
            proposal.status = PROPOSAl_STATUS_PASS;
        }else if (against_vote_power > (voting_power::total_voting_power() - voting_power::quorum_threshold())){
            proposal.status = PROPOSAl_STATUS_FAIL; 
        };


        let vote_event = VoteProposalEvent{
            proposal_id: object::id(proposal),
            voter: sender,
            agree,
            status: proposal.status
        };

        event::emit(vote_event);
    }

    public fun proposal_status(self: &Proposal,clock: &Clock):u8{
        if(self.start_time_ms > clock.timestamp_ms()){
            PROPOSAl_STATUS_PENDING
        }else if(self.status ==  PROPOSAl_STATUS_ACTIVE && clock.timestamp_ms() > self.end_time_ms){
            PROPOSAl_STATUS_TIMEOUT
        }else {
            self.status
        }
    }

    public fun proposal_action_type(self: &Proposal):String{
        self.action_type
    }


    public fun proposal_status_pass():u8{
        PROPOSAl_STATUS_PASS
    }


    public fun action<Action:store>(self: &Proposal):&Action{
        df::borrow<ActionKey,Action>(&self.id, ActionKey{})
    }


    public(package) fun create_proposal<Action:store>(
        self: &mut SupperCommittee,
        validator_address: address,
        validator_vote_powers: VecMap<address,u64>,
        action: Action,
        clock: &Clock,
        ctx: &mut TxContext,
    ){
        let action_type = type_name::get<Action>();
        // only sui_system action struct types
        assert!(action_type.get_address() == address::to_ascii_string(@0x3),ENotSupportStructType);

        let mut proposal = Proposal{
            id: object::new(ctx),
            proposer: validator_address,
            for_votes: vec_set::empty(),
            against_votes: vec_set::empty(),
            start_time_ms: clock.timestamp_ms(),
            end_time_ms:clock.timestamp_ms() + Timeout,
            status: PROPOSAl_STATUS_ACTIVE,
            action_type: action_type.into_string(),
        };

        let create_proposal_event = CreateProposalEvent{
            proposal_id: object::id(&proposal),
            proposer: proposal.proposer,
            action_type: proposal.action_type
        };


        proposal.vote_proposal(
            validator_vote_powers, 
            validator_address, 
            true,
            clock,
            ctx,
        );
        
        df::add(&mut proposal.id, ActionKey{}, action);

        self.proposal_list.push_back(object::id(&proposal));

        transfer::share_object(proposal);

        event::emit(create_proposal_event);
    }


    fun get_vote_power(
        self: &Proposal,
        validator_vote_powers: VecMap<address,u64>,
    ):(u64,u64){
        let mut  for_vote_power = 0;
        let mut  against_votes = 0;

        self.for_votes.keys().do_ref!(|c| {
            let vote_power = validator_vote_powers.try_get(c);
            if (vote_power.is_some()){
                for_vote_power  = for_vote_power + vote_power.destroy_some();
            };
        } );

        self.against_votes.keys().do_ref!(|c|{
            let vote_power = validator_vote_powers.try_get(c);
            if (vote_power.is_some()){
                against_votes  = against_votes + vote_power.destroy_some();
            };
        } );

        (for_vote_power,against_votes)
    }


}