class PostsController < ApplicationController
  
  before_filter :login_required, :except => [:index, :show, :show_by_category]
  
  # GET /posts
  # GET /posts.xml
  def index
    #@posts = Post.all(:order => "created_at DESC", :limit => "25") 
    
    @categories = Category.all
    @posts1 = Post.all(:conditions => ["category_id = 1"], :order => "created_at DESC", :limit => "25")
    @posts2 = Post.all(:conditions => ["category_id = 2"], :order => "created_at DESC", :limit => "25")
    @posts3 = Post.all(:conditions => ["category_id = 3"], :order => "created_at DESC", :limit => "25")
    @posts4 = Post.all(:conditions => ["category_id = 4"], :order => "created_at DESC", :limit => "25")
    @posts5 = Post.all(:conditions => ["category_id = 5"], :order => "created_at DESC", :limit => "25")
    @posts6 = Post.all(:conditions => ["category_id = 6"], :order => "created_at DESC", :limit => "25")

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id].to_i)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  def show_by_category
    @category = Category.find_by_name(params[:name])
    @posts = Post.paginate(:page => params[:page], :conditions => ["category_id =?",@category], :order => "created_at DESC", :limit => "25")
    #@posts = Post.find(:all, :conditions => ["category_id =?",@category], :order => "created_at DESC", :limit => "25")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end    
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    1.upto(3) { @post.photos.build } # added for paperclip photos

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if @post.photos.first.nil?
        1.upto(3) { @post.photos.build }
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id # need to add user_id to the entry

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    unless params[:photo_ids].empty?
        Photo.destroy_pics(params[:id], params[:photo_ids])
    end
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  # this function is to update the number of characters in the new post form
  # it is not used. see posts_helper instead
  def check_length
    body_text = request.raw_post || request.query_string
    
    total_words = body_text.split(/\s+/).length
    total_chars = body_text.length
    if (total_chars >= 100)
      render :text => "<p class=\"error\">You have #{total_chars} characters; #{total_words} words.</p>"
    else
      render :nothing => true
    end
  end
  
end
